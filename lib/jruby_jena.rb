require 'java'
[
  'jruby_jena/jars',
  'jruby_jena/version',
  'jruby_jena/query_utils'
].each {|f| require f}

# Short names for commonly used Java packages
module Jena
  JENA = "com.hp.hpl.jena"
end

# make some handy classes available in the top-level namespace
module Jena
  java_import com.hp.hpl.jena.rdf.model.ModelFactory
  java_import com.hp.hpl.jena.rdf.model.ResourceFactory
  java_import com.hp.hpl.jena.rdf.model.Resource
  java_import com.hp.hpl.jena.rdf.model.Literal
  java_import com.hp.hpl.jena.rdf.model.RDFNode

  java_import com.hp.hpl.jena.util.FileManager

  java_import com.hp.hpl.jena.vocabulary.RDF
  java_import com.hp.hpl.jena.vocabulary.RDFS
  java_import com.hp.hpl.jena.vocabulary.OWL

  java_import com.hp.hpl.jena.query.QueryFactory
  java_import com.hp.hpl.jena.query.QueryExecutionFactory
end