require 'java'
[
  'jruby_jena/jars',
  'jruby_jena/version'
].each {|f| require f}

# Short names for commonly used Java packages
module Jena
  JENA = "com.hp.hpl.jena"
  RDF = "#{JENA}.rdf"
  MODEL = "#{RDF}.model"
  UTIL = "#{RDF}.util"
  VOCABULARY = "#{JENA}.vocabulary"
end

["#{Jena::MODEL}.ModelFactory",
 "#{Jena::MODEL}.Resource",
 "#{Jena::MODEL}.Literal",
 "#{Jena::MODEL}.RDFNode",
 "#{Jena::UTIL}.FileManager",
 "#{Jena::VOCABULARY}.RDF",
 "#{Jena::VOCABULARY}.RDFS",
 "#{Jena::VOCABULARY}.OWL"
].each {|name| java_import name}
