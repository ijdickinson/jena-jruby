$LOAD_PATH.push "#{File.dirname(__FILE__)}/../lib"
require "rubygems"
require "test/unit"
#require "test/unit/runner/tk"
require "jruby_jena"

class QueryUtilsTest < Test::Unit::TestCase

  def setup
    @m = Jena::ModelFactory.createDefaultModel
    @r0 = @m.createResource "http://example.org/foo#r0"
    @m.add @r0, Jena::RDFS.comment, "this is a test"
  end

  def teardown
  end

  def test_as_prefix_map_0
    pm = com.hp.hpl.jena.shared.impl.PrefixMappingImpl.new
    assert_same pm, Jena.as_prefix_map( pm )
  end

  def test_as_prefix_map_1
    map = {"foo" => "http://foo.bar"}
    pm = Jena.as_prefix_map map
    assert_equal "http://foo.bar", pm.getNsPrefixURI( "foo" )
  end

  def test_as_bindings_0
    qsm = com.hp.hpl.jena.query.QuerySolutionMap.new
    assert_same qsm, Jena.as_bindings( qsm )
  end

  def test_as_bindings_1
    r = com.hp.hpl.jena.rdf.model.ResourceFactory.createResource "http://foo.bar#"
    b = {"r" => r}
    assert_equal r, Jena.as_bindings( b ).get( "r" )
  end

  # Generic form of query_select
  def test_query_select_0
    result = Jena.query_select @m, "select * {?s ?p ?o}", nil
    assert_equal 1, result.size

    assert_equal @r0, result[0][:s]
    assert_equal Jena::RDFS.comment, result[0][:p]
    assert_equal "this is a test", result[0][:o].getLexicalForm
  end

  # Project variables from query_select
  def test_query_select_1
    result = Jena.query_select @m, "select * {?s ?p ?o}", nil, "s"
    assert_equal 1, result.size

    assert_equal @r0, result[0][:s]
    assert ! result[0].has_key?( :p )
    assert ! result[0].has_key?( :o )

    result = Jena.query_select @m, "select * {?s ?p ?o}", nil, :s
    assert_equal 1, result.size

    assert_equal @r0, result[0][:s]
  end

  # Use namespaces in query select
  def test_query_select_2
    ns = {:foo => "http://example.org/foo#"}

    result = Jena.query_select @m, "select * {foo:r0 ?p ?o}", {:ns => ns}
    assert_equal 1, result.size

    assert ! result[0].has_key?( :s )
    assert_equal Jena::RDFS.comment, result[0][:p]
    assert_equal "this is a test", result[0][:o].getLexicalForm
  end

  # Use variable bindings in query select
  def test_query_select_3
    b = {:s => @r0}

    r1 = @m.createResource "http://example.org/foo#r1"
    @m.add r1, Jena::RDFS.comment, "this is another test"

    result = Jena.query_select @m, "select * {?s ?p ?o}", {:bindings => b}
    assert_equal 1, result.size

    assert_equal @r0, result[0][:s]
  end

  # Get only one result
  def test_query_select_first
    @m.add @r0, Jena::RDFS.comment, "this is another test"

    result = Jena.query_select @m, "select * {?s ?p ?o}"
    assert_equal 2, result.size

    result = Jena.query_select @m, "select * {?s ?p 42}"
    assert_equal 0, result.size

    result = Jena.query_select_first @m, "select * {?s ?p ?o}"
    assert_equal @r0, result[:s]

    result = Jena.query_select_first @m, "select * {?s ?p 42}"
    assert_nil result
  end
end