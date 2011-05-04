Dir.glob('jruby_jena/*.rb').each do |f|
  require f.gsub( /\.rb$/, '' )
end

# Short names for commonly used Java packages
module JENA
  jena = "com.hp.hpl.jena"
  rdf = "#{jena}.rdf"
  model = "#{rdf}.model"
  util = "#{rdf}.util"
  vocabulary = "#{jena}.vocabulary"
end

["#{JENA::model}.ModelFactory",
 "#{JENA::model}.Resource",
 "#{JENA::model}.Literal",
 "#{JENA::model}.RDFNode",
 "#{JENA::util}.FileManager",
 "#{JENA::vocabulary}.RDF",
 "#{JENA::vocabulary}.RDFS",
 "#{JENA::vocabulary}.OWL"
].each {|name| java_import name}
