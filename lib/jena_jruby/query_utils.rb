module Jena
  module Query
    # Perform a SPARQL select query against the given model. Returns
    # an array of result objects, where each result is a Hash from
    # query variable name to value.
    #
    # By default, all variables from the query are returned. To return
    # just a subset of the query variables, pass the variable name(s) as
    # the last argument to the call.
    #
    # Various options are supported:
    # * `:ns` - a `PrefixMapping` or hash of prefixes to URI's
    # * `:bindings` - a `QuerySolutionMap` or hash of existing var name to value pairs
    #
    # == Examples
    #     Jena.querySelect( m, 'select * where {?s ?p ?o}' )
    #     Jena.querySelect( m, 'select * where {?s ?p ?o}', {}, "s" )
    #     Jena.querySelect( m, 'select * where {?s ?p foo:bar}',
    #       {:ns => {"foo" => "http://example.com/foo#"}}, "s" )
    #
    # @param m [Model] The model to run the query against
    # @param query [String] The query to run
    # @param options [Hash] Options (see above)
    # @param *vars [String] Optional variables to project from results
    # @return [Array] Non-nil array of hashes, one per result
    def self.select( m, query, options = nil, *vars )
      results = []
      select_each( m, query, options, *vars ) {|soln| results << soln}
      results
    end

    # Perform a select query as per {#select}, but returns only the first
    # result, if defined, or nil
    def self.select_first( m, query, options = nil, *vars )
      qexec = setup_query_execution( m, query, options )
      result = nil

      begin
        rs = qexec.execSelect
        result = project_variables( rs.next, *vars ) if rs.hasNext
      ensure
        qexec.close
      end

      result
    end

    # Perform a select query as per {#select}, but rather than accumulate
    # an array of results, we yield to the associated block with each solution
    def self.select_each( m, query, options = nil, *vars, &block )
      select_each_qe( setup_query_execution( m, query, options ), *vars, &block )
    end

    # Perform a select query using the given query execution, yielding to the
    # associated block for each solution
    def self.select_each_qe( qexec, *vars )
      begin
        qexec.execSelect.each do |soln|
          yield( project_variables( soln, *vars ) )
        end
      ensure
        qexec.close
      end
    end

    # Perform a SPARQL describe query. Options as per {#select},
    # but this call returns a `Model`.
    #
    # @param m [Model] The model to run the query against
    # @param query [String] The query to run
    # @param options [Hash] Options (see above)
    # @return [Array] Non-empty array of hashes, one per result
    def self.describe( m, query, options = nil )
      describe_qe( setup_query_execution( m, query, options ) )
    end

    # Perform a describe query using the given query execution object, and
    # return the resulting model
    def self.describe_qe( qexec )
      begin
        return qexec.execDescribe
      ensure
        qexec.close
      end
    end

    # Project variables from a result set entry, returning a `Hash` of variable
    # names to values
    def self.project_variables( soln, *vars )
      nn = Hash.new

      vs = vars || []
      soln.varNames.each {|v| vs << v} if vs.empty?

      vs.each {|v| nn[v.to_sym] = soln.get( v )}

      nn
    end

    # Return the given bindings object as a `QuerySolutionsMap`. Convert a
    # hash to a `QuerySolutionsMap` if necessary
    def self.as_bindings( b )
      return nil unless b
      return b if b.is_a? com.hp.hpl.jena.query.QuerySolutionMap
      qsm = com.hp.hpl.jena.query.QuerySolutionMap.new
      b.each_pair do |k,v|
        qsm.add k, v
      end
      qsm
    end

    # A mutable collection of well-known namespace prefixes, which can
    # be used as a basis for building up a larger collection
    def self.useful_prefixes
      pm = com.hp.hpl.jena.shared.impl.PrefixMappingImpl.new
      pm.setNsPrefixes( com.hp.hpl.jena.shared.PrefixMapping.Standard )
      pm
    end

    # Return true if a string represents a valid SPARQL query.
    def self.valid?( query_string, syntax = Jena::Query::Syntax.syntaxSPARQL_11 )
      q = Jena::Query::QueryFactory.create

      begin
        Jena::Query::QueryFactory.parse( q, query_string, nil, syntax )
        return true
      rescue
      end

      false
    end

    # Return a QueryExecution for executing the given query against a
    # remote SPARQL service endpoint
    def self.sparql_service( url, query )
      Jena::Query::QueryExecutionFactory.sparqlService( url, query )
    end

    # Return a list of the solutions to executing the given select query
    # against the given remote SPARQL endpoint
    def self.service_select( url, query, *vars )
      results = []
      select_each_qe( sparql_service( url, query ), *vars ) {|soln| results << soln}
      results
    end

    # Yield to the associated block for each solution to the given query against
    # the given SPARQL service endpoint URL
    def self.service_select_each( url, query, *vars, &block )
      select_each_qe( sparql_service( url, query ), *vars, &block )
    end

    # Return a model from a describe query against a remote SPARQL endpoint
    def self.service_describe( url, query )
      describe_qe( sparql_service( url, query ) )
    end

    # Format a given value in a manner suitable for inclusion in a SPARQL query
    def self.sparql_format( value )
      if value.is_a? Core::Resource
        value.is_anon ? "_:#{value.get_id.to_string.gsub(/[^[[:alnum:]]]/, '_')}" : "<#{value.get_uri}>"
      elsif value.is_a? Core::Literal
        if dt = value.get_datatype_uri
          "\"#{value.get_lexical_form}\"^^<#{dt}>"
        else
          "\"#{value.to_string}\""
        end
      elsif value.to_s =~ /\A(file|http):\/\//
        "<#{value}>"
      elsif value.to_s =~ /\A[-_[[:alnum:]]]*:/
        # looks like a qname
        value.to_s
      else
        # guess
        "\"#{value.to_s}\""
      end
    end

    :private

    def self.option( options, opt, default )
      if has_option?( options, opt ) then options[opt] else default end
    end

    def self.has_option?( options, opt )
      options && options.has_key?( opt )
    end

    # Common part of setting up a query execution
    def self.setup_query_execution( m, query, options )
      q = com.hp.hpl.jena.query.Query.new

      q.setPrefixMapping has_option?( options, :ns ) ? Util::as_prefix_map( options[:ns] ) : useful_prefixes

      baseURI = option( options, :baseURI, nil )
      syntax = option( options, :syntax, com.hp.hpl.jena.query.Syntax.syntaxSPARQL_11 )

      QueryFactory.parse( q, query, baseURI, syntax )
      bindings = as_bindings( option( options, :bindings, nil ) )

      bindings ? QueryExecutionFactory.create( q, m, bindings ) : QueryExecutionFactory.create( q, m )
    end

  end
end