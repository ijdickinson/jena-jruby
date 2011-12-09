$LOAD_PATH.push "#{File.dirname(__FILE__)}/../lib"
require "rubygems"
require "test/unit"
require "jruby_jena"

class NodeUtilsTest < Test::Unit::TestCase

  def setup
    @m = Jena::Core::ModelFactory.createDefaultModel
    @r0 = @m.createResource "http://example.org/foo#r0"
    @r1 = @m.createResource "http://example.org/foo#r1"
    @m.add @r0, Jena::Vocab::RDFS.comment, "this is a test"
    @m.add @r0, Jena::Vocab::RDF.type, @r1
  end

  def teardown
  end

  def test_resource_types
    assert_equal [@r1], @r0.types
    assert_equal [], @r1.types
  end

  def test_literal_types
    lit = @m.createTypedLiteral( 10 )
    types = lit.types
    assert_equal "http://www.w3.org/2001/XMLSchema#long", types.first.getURI
    assert_equal 1, types.length

    lit = @m.createLiteral( "foo" )
    types = lit.types
    assert_equal 0, types.length
  end

  def test_default_type
    assert_equal [@r1, Jena::Vocab::RDF::Property], Jena::Node.types( @r0, Jena::Vocab::RDF::Property )
    assert_equal [Jena::Vocab::RDF::Property], Jena::Node.types( @r1, Jena::Vocab::RDF::Property )

    assert_equal [:dummy], Jena::Node.types( @m.createLiteral( "foo" ), :dummy )
  end

  def test_resolve_properties
    p = @m.createProperty( "http://example.com/p" )
    assert_equal [p], @r0.resolve_properties( [p] )
    assert_equal [p], @r0.resolve_properties( ["http://example.com/p"] )
    @m.setNsPrefix( "eg", "http://example.com/" )
    assert_equal [p], @r0.resolve_properties( ["eg:p"] )
  end

  def test_property_values
    assert_equal [@r1], @r0.property_values( Jena::Vocab::RDF.type )
    assert_equal [@r1], @r0.property_values( Jena::Vocab::RDF.type.getURI )
    @m.setNsPrefix( "rdf", Jena::Vocab::RDF.getURI )
    assert_equal [@r1], @r0.property_values( "rdf:type" )
  end

  def test_property_values_with_explicit_model
    @m.setNsPrefix( "rdf", Jena::Vocab::RDF.getURI )

    # r is not attached to any model
    r = Jena::Core::ResourceFactory.createResource( @r0.getURI )

    assert_equal [], r.property_values( Jena::Vocab::RDF.type )
    assert_equal [], r.property_values( Jena::Vocab::RDF.type.getURI )
    assert_equal [], r.property_values( "rdf:type" )

    assert_equal [@r1], r.property_values( Jena::Vocab::RDF.type, @m )
    assert_equal [@r1], r.property_values( Jena::Vocab::RDF.type.getURI, @m )
    assert_equal [@r1], r.property_values( "rdf:type", @m )
  end
end