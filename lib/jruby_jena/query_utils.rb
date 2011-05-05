module Jena
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
  #       {:ns => {"foo", "http://example.com/foo#"}}, "s" )
  #
  # @param m [Model] The model to run the query against
  # @param query [String] The query to run
  # @param options [Hash] Options (see above)
  # @param *vars [String] Optional variables to project from results
  def self.query_select( m, query, options = nil, *vars )
    results = []

    q = com.hp.hpl.jena.query.Query.new
    q.setPrefixMapping( as_prefix_map options[:ns] ) if has_option? options, :ns

    baseURI = option options, :baseURI, nil
    syntax = option options, :syntax, com.hp.hpl.jena.query.Syntax.syntaxSPARQL_11

    QueryFactory.parse( q, query, baseURI, syntax )
    qexec = QueryExecutionFactory.create( q, m, as_bindings( option options, :bindings, nil ) )

    begin
      qexec.execSelect.each do |soln|
        results << project_variables( soln, vars )
      end
    ensure
      qexec.close
    end

    results
  end

  # Project variables from a result set entry, returning a `Hash` of variable
  # names to values
  def self.project_variables( soln, vars )
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

  # Return the given prefix map object as a `PrefixMapping`. Convert a hash
  # to a `PrefixMapping` if necessary
  def self.as_prefix_map( map )
    return nil unless map
    return map if map.is_a? com.hp.hpl.jena.shared.PrefixMapping
    pm = com.hp.hpl.jena.shared.impl.PrefixMappingImpl.new
    map.each_pair do |k,v|
      pm.setNsPrefix k.to_s, v.to_s
    end
    pm
  end

  :private

  def self.option( options, opt, default )
    if has_option?( options, opt ) then options[opt] else default end
  end

  def self.has_option?( options, opt )
    options && options.has_key?( opt )
  end
end