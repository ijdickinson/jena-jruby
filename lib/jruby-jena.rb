# Short names for commonly used Java classes
jena = "com.hp.hpl.jena"
rdf = "#{jena}.rdf"
vocab = "#{jena}.vocabulary"

["#{rdf}.model.ModelFactory",
 "#{rdf}.model.Resource",
 "#{rdf}.model.Literal",
 "#{rdf}.model.RDFNode",
 "#{jena}.util.FileManager",
 "#{vocab}.RDF",
 "#{vocab}.RDFS",
 "#{vocab}.OWL"
].each {|name| java_import name}
