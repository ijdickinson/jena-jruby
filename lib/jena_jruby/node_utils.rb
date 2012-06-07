module Jena
  # A collection of utilities for manipulating Jena RDF Resources
  # and Literals, collectively known as RDFNodes.
  module Node
    # Return the types of a node, which will be an array of the RDF types
    # for a resource, or an array of the (zero or one) datatypes if the
    # node is a literal. Ensures that the returned array includes the default_type
    # f default_type is non-nil
    def self.types( node, default_type = nil )
      return self.resource_types( node, default_type ) if node.resource?
      self.literal_types( node, default_type )
    end

    # Return the values of `rdf:type` for the given resource
    def self.resource_types( node, default_type = nil )
      types = []
      node.each_property( Jena::Vocab::RDF.type ) {|stmt| types << stmt.getObject}
      with_default_type( types, default_type )
    end

    # Return an array of the datatype of the given literal, if defined,
    # and including the default_type if non-nil
    def self.literal_types( node, default_type = nil )
      types = node.getDatatype ? [node.getDatatype] : []
      with_default_type( types, default_type )
    end

    :private

    def self.with_default_type( types, default_type )
      types << default_type if default_type && !types.include?( default_type )
      types
    end
  end
end


# Add some Ruby-friendly method names to common Jena classes
module Java
  module ComHpHplJenaEnhanced
    class EnhNode
      def types
        Jena::Node.types self
      end
    end
  end

  module ComHpHplJenaRdfModelImpl
    class ResourceImpl
      # Return the resource types
      def types
        Jena::Node.types self
      end

      # Yield to the given block for each statement of this resource with predicate
      # `property`. If `property` is nil, yield to the block for every statement whose
      # subject is this resource.
      def each_property( property = nil, &block )
        listProperties( property ).each( &block )
      end

      # Return a list of the values of the given properties of this resource. Each property
      # may be specified as a +Property+ object, a string denoting the URI, or a string
      # denoting the URI in <tt>prefix:name</tt> format, which will be expanded using the
      # prefix table attached to the resource's model
      def property_values( props = nil, model = nil )
        model ||= getModel
        return [] unless model

        values = []
        resolve_properties( props, model ).each do |p|
          model.listStatements( self, p, nil ).each do |stmt|
            values << stmt.getObject
          end
        end
        values
      end

      # Return a list of Jena +Property+ objects corresponding to the list of property
      # names +props+. Each member of +props+ is either
      # * a +Property+ object, which is returned unchanged
      # * a URI string, which is converted to a +Property+
      # * an abbreviated URI in <tt>prefix:name</tt> form, which is expanded using the prefixes
      #   defined in the current model before being converted to a +Property+ object
      #
      # In the special case of <tt>props = nil</tt>, the returned list is all of the distinct
      # properties attached to this resource
      def resolve_properties( props = nil, model = nil )
        props = [props] unless props.is_a? Array
        model ||= self.getModel

        unless props
          return model.listStatements( self, nil, nil ).map {|stmt| stmt.getPredicate} .uniq
        end

        props.map do |p|
          case
          when p.is_a?( Jena::Core::Property )
            p
          when model
            model.getProperty( model.expandPrefix( p ) )
          else
            Jena::Core::ResourceFactory.getProperty( p )
          end
        end
      end
    end
  end
end
