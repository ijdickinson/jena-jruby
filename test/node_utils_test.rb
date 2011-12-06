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
end