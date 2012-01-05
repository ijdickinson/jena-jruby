module Jena
  module Vocab

    # A namespace is an object for resolving identifiers in scope denoted
    # by a base URI to a full URI. For example,
    #
    #    rdfs = Namespace.new( "http://www.w3.org/2000/01/rdf-schema#" )
    #    rdfs.comment # => "http://www.w3.org/2000/01/rdf-schema#comment"
    #
    # There is no checking that the resolved name is known in the defined
    # namespace (e.g. <tt>rdfs.commnet</tt> will work without a warning)
    class Namespace
      attr_reader :ns

      # Initialize this namespace with the given root URI. E.g, for RDFS,
      # this would be
      #    rdfs = Namespace.new( "http://www.w3.org/2000/01/rdf-schema#" )
      def initialize( ns )
        @ns = ns
      end

      :private

      def method_missing( name, *args)
        prop = !args.empty? && args.first
        n = "#{@ns}#{name}"
        prop ? Jena::Core::ResourceFactory.createProperty(n) : Jena::Core::ResourceFactory.createResource(n)
      end
    end

    # A namespace object for the SKOS vocabulary, which is not built-in to Jena
    SKOS = Namespace.new( "http://www.w3.org/2004/02/skos/core#" )
  end
end