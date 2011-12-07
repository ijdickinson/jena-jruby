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
      types = node.getDatatype.to_a || []
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
      alias resource? isResource
      alias literal? isLiteral

      def types
        Jena::Node.types self
      end
    end
  end

  module ComHpHplJenaRdfModelImpl
    class ResourceImpl
      # Yield to the given block for each statement of this resource with predicate
      # `property`. If `property` is nil, yield to the block for every statement whose
      # subject is this resource.
      def each_property( property = nil, &block )
        listProperties( property ).each( &block )
      end
    end
  end
end
