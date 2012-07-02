$LOAD_PATH.push "#{File.dirname(__FILE__)}/../lib"
$LOAD_PATH.push "#{File.dirname(__FILE__)}/../javalib"
require "rubygems"
require "test/unit"
require "jena_jruby"

class QueryUtilsTest < Test::Unit::TestCase

  def setup
    @m = Jena::Core::ModelFactory.createDefaultModel
    @r0 = @m.createResource "http://example.org/foo#r0"
    @m.add @r0, Jena::Vocab::RDFS.comment, "this is a test"
  end

  def teardown
  end

  def test_as_prefix_map_0
    pm = com.hp.hpl.jena.shared.impl.PrefixMappingImpl.new
    assert_same pm, Jena::Util.as_prefix_map( pm )
  end

  def test_as_prefix_map_1
    map = {"foo" => "http://foo.bar"}
    pm = Jena::Util.as_prefix_map map
    assert_equal "http://foo.bar", pm.getNsPrefixURI( "foo" )
  end

  def test_as_bindings_0
    qsm = Jena::Query::QuerySolutionMap.new
    assert_same qsm, Jena::Query.as_bindings( qsm )
  end

  def test_as_bindings_1
    r = Jena::Core::ResourceFactory.createResource "http://foo.bar#"
    b = {"r" => r}
    assert_equal r, Jena::Query.as_bindings( b ).get( "r" )
  end

  # Generic form of select
  def test_select_0
    result = Jena::Query.select @m, "select * {?s ?p ?o}", nil
    assert_equal 1, result.size

    assert_equal @r0, result[0][:s]
    assert_equal Jena::Vocab::RDFS.comment, result[0][:p]
    assert_equal "this is a test", result[0][:o].getLexicalForm
  end

  # Project variables from select
  def test_select_1
    result = Jena::Query.select @m, "select * {?s ?p ?o}", nil, "s"
    assert_equal 1, result.size

    assert_equal @r0, result[0][:s]
    assert ! result[0].has_key?( :p )
    assert ! result[0].has_key?( :o )

    result = Jena::Query.select @m, "select * {?s ?p ?o}", nil, :s
    assert_equal 1, result.size

    assert_equal @r0, result[0][:s]
  end

  # Use namespaces in query select
  def test_select_2
    ns = {:foo => "http://example.org/foo#"}

    result = Jena::Query.select @m, "select * {foo:r0 ?p ?o}", {:ns => ns}
    assert_equal 1, result.size

    assert ! result[0].has_key?( :s )
    assert_equal Jena::Vocab::RDFS.comment, result[0][:p]
    assert_equal "this is a test", result[0][:o].getLexicalForm
  end

  # Use variable bindings in query select
  def test_select_3
    b = {:s => @r0}

    r1 = @m.createResource "http://example.org/foo#r1"
    @m.add r1, Jena::Vocab::RDFS.comment, "this is another test"

    result = Jena::Query.select @m, "select * {?s ?p ?o}", {:bindings => b}
    assert_equal 1, result.size

    assert_equal @r0, result[0][:s]
  end

  # Get only one result
  def test_select_first
    @m.add @r0, Jena::Vocab::RDFS.comment, "this is another test"

    result = Jena::Query.select @m, "select * {?s ?p ?o}"
    assert_equal 2, result.size

    result = Jena::Query.select @m, "select * {?s ?p 42}"
    assert_equal 0, result.size

    result = Jena::Query.select_first @m, "select * {?s ?p ?o}"
    assert_equal @r0, result[:s]

    result = Jena::Query.select_first @m, "select * {?s ?p 42}"
    assert_nil result
  end

  # SPARQL formatting tests
  def test_sparql_format
    assert_equal "<http://foo.bar>", Jena::Query.sparql_format( @m.create_resource( "http://foo.bar" ))
    assert_equal '"foo"', Jena::Query.sparql_format( @m.create_literal( "foo" ))
    assert_equal '"42"^^<http://www.w3.org/2001/XMLSchema#long>', Jena::Query.sparql_format( @m.create_typed_literal( 42 ))
    assert_equal "foo:bar", Jena::Query.sparql_format( "foo:bar" )
    assert_equal "<http://foo.bar>", Jena::Query.sparql_format( "http://foo.bar" )
    assert Jena::Query.sparql_format( @m.create_resource ).match( /_:([[:alnum:]]*)/ )
  end
end