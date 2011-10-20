require 'java'
%w[
  jars
  version
  utils
  query_utils
].each {|f| require "jruby_jena/#{f}"}

# Short names for commonly used Java packages
module Jena
  JENA = "com.hp.hpl.jena"
end

# Make a selection of key Jena classes available in a convenient module
module Jena
  module Core
    java_import com.hp.hpl.jena.rdf.model.Alt
    java_import com.hp.hpl.jena.rdf.model.AnonId
    java_import com.hp.hpl.jena.rdf.model.Bag
    java_import com.hp.hpl.jena.rdf.model.Container
    java_import com.hp.hpl.jena.rdf.model.InfModel
    java_import com.hp.hpl.jena.rdf.model.Literal
    java_import com.hp.hpl.jena.rdf.model.ModelChangedListener
    java_import com.hp.hpl.jena.rdf.model.ModelFactory
    java_import com.hp.hpl.jena.rdf.model.ModelGetter
    java_import com.hp.hpl.jena.rdf.model.ModelGraphInterface
    java_import com.hp.hpl.jena.rdf.model.Model
    java_import com.hp.hpl.jena.rdf.model.ModelMaker
    java_import com.hp.hpl.jena.rdf.model.ModelReader
    java_import com.hp.hpl.jena.rdf.model.ModelSource
    java_import com.hp.hpl.jena.rdf.model.NodeIterator
    java_import com.hp.hpl.jena.rdf.model.NsIterator
    java_import com.hp.hpl.jena.rdf.model.Property
    java_import com.hp.hpl.jena.rdf.model.RDFErrorHandler
    java_import com.hp.hpl.jena.rdf.model.RDFList
    java_import com.hp.hpl.jena.rdf.model.RDFNode
    java_import com.hp.hpl.jena.rdf.model.RDFReader
    java_import com.hp.hpl.jena.rdf.model.RDFVisitor
    java_import com.hp.hpl.jena.rdf.model.RDFWriter
    java_import com.hp.hpl.jena.rdf.model.ReifiedStatement
    java_import com.hp.hpl.jena.rdf.model.ResIterator
    java_import com.hp.hpl.jena.rdf.model.ResourceFactory
    java_import com.hp.hpl.jena.rdf.model.Resource
    java_import com.hp.hpl.jena.rdf.model.RSIterator
    java_import com.hp.hpl.jena.rdf.model.Schema
    java_import com.hp.hpl.jena.rdf.model.Selector
    java_import com.hp.hpl.jena.rdf.model.Seq
    java_import com.hp.hpl.jena.rdf.model.SimpleSelector
    java_import com.hp.hpl.jena.rdf.model.StatementBoundary
    java_import com.hp.hpl.jena.rdf.model.Statement
    java_import com.hp.hpl.jena.rdf.model.StatementTripleBoundary
    java_import com.hp.hpl.jena.rdf.model.StmtIterator
  end

  module Util
    java_import com.hp.hpl.jena.util.CharEncoding
    java_import com.hp.hpl.jena.util.CollectionFactory
    java_import com.hp.hpl.jena.util.FileManager
    java_import com.hp.hpl.jena.util.FileUtils
    java_import com.hp.hpl.jena.util.IteratorCollection
    java_import com.hp.hpl.jena.util.LocationMapper
    java_import com.hp.hpl.jena.util.LocatorClassLoader
    java_import com.hp.hpl.jena.util.LocatorFile
    java_import com.hp.hpl.jena.util.Locator
    java_import com.hp.hpl.jena.util.LocatorURL
    java_import com.hp.hpl.jena.util.LocatorZip
    java_import com.hp.hpl.jena.util.Metadata
    java_import com.hp.hpl.jena.util.ModelLoader
    java_import com.hp.hpl.jena.util.ModelQueryUtil
    java_import com.hp.hpl.jena.util.MonitorGraph
    java_import com.hp.hpl.jena.util.MonitorModel
    java_import com.hp.hpl.jena.util.OneToManyMap
    java_import com.hp.hpl.jena.util.PrintUtil
    java_import com.hp.hpl.jena.util.QueryMapper
    java_import com.hp.hpl.jena.util.ResourceUtils
    java_import com.hp.hpl.jena.util.SystemUtils
    java_import com.hp.hpl.jena.util.Tokenizer
    java_import com.hp.hpl.jena.util.TypedStream
    java_import com.hp.hpl.jena.util.URIref
    java_import com.hp.hpl.jena.shared.Command
    java_import com.hp.hpl.jena.shared.Lock
    java_import com.hp.hpl.jena.shared.LockMRSW
    java_import com.hp.hpl.jena.shared.LockMutex
    java_import com.hp.hpl.jena.shared.LockNone
    java_import com.hp.hpl.jena.shared.PrefixMapping
    java_import com.hp.hpl.jena.shared.RandomOrderGraph
    java_import com.hp.hpl.jena.shared.ReificationStyle
    java_import com.hp.hpl.jena.shared.uuid.JenaUUID
    java_import com.hp.hpl.jena.shared.uuid.UUIDFactory
  end

  module Vocab
    java_import com.hp.hpl.jena.vocabulary.DB
    java_import com.hp.hpl.jena.vocabulary.DC_10
    java_import com.hp.hpl.jena.vocabulary.DC_11
    java_import com.hp.hpl.jena.vocabulary.DC
    java_import com.hp.hpl.jena.vocabulary.DCTerms
    java_import com.hp.hpl.jena.vocabulary.DCTypes
    java_import com.hp.hpl.jena.vocabulary.LocationMappingVocab
    java_import com.hp.hpl.jena.vocabulary.OntDocManagerVocab
    java_import com.hp.hpl.jena.vocabulary.OntEventsVocab
    java_import com.hp.hpl.jena.vocabulary.OWL2
    java_import com.hp.hpl.jena.vocabulary.OWL
    java_import com.hp.hpl.jena.vocabulary.RDF
    java_import com.hp.hpl.jena.vocabulary.RDFS
    java_import com.hp.hpl.jena.vocabulary.RDFSyntax
    java_import com.hp.hpl.jena.vocabulary.ReasonerVocabulary
    java_import com.hp.hpl.jena.vocabulary.ResultSet
    java_import com.hp.hpl.jena.vocabulary.RSS
    java_import com.hp.hpl.jena.vocabulary.VCARD
    java_import com.hp.hpl.jena.vocabulary.XSD
  end

  module Query
    java_import com.hp.hpl.jena.query.ARQ
    java_import com.hp.hpl.jena.query.DatasetFactory
    java_import com.hp.hpl.jena.query.Dataset
    java_import com.hp.hpl.jena.query.DataSource
    java_import com.hp.hpl.jena.query.QueryExecutionFactory
    java_import com.hp.hpl.jena.query.QueryExecution
    java_import com.hp.hpl.jena.query.QueryFactory
    java_import com.hp.hpl.jena.query.Query
    java_import com.hp.hpl.jena.query.QuerySolution
    java_import com.hp.hpl.jena.query.QuerySolutionMap
    java_import com.hp.hpl.jena.query.QueryVisitor
    java_import com.hp.hpl.jena.query.ResultSetFactory
    java_import com.hp.hpl.jena.query.ResultSetFormatter
    java_import com.hp.hpl.jena.query.ResultSet
    java_import com.hp.hpl.jena.query.ResultSetRewindable
    java_import com.hp.hpl.jena.query.SortCondition
    java_import com.hp.hpl.jena.query.Syntax
  end

  module Ont
    java_import com.hp.hpl.jena.ontology.AllDifferent
    java_import com.hp.hpl.jena.ontology.AllValuesFromRestriction
    java_import com.hp.hpl.jena.ontology.AnnotationProperty
    java_import com.hp.hpl.jena.ontology.BooleanClassDescription
    java_import com.hp.hpl.jena.ontology.CardinalityQRestriction
    java_import com.hp.hpl.jena.ontology.CardinalityRestriction
    java_import com.hp.hpl.jena.ontology.ComplementClass
    java_import com.hp.hpl.jena.ontology.DataRange
    java_import com.hp.hpl.jena.ontology.DatatypeProperty
    java_import com.hp.hpl.jena.ontology.EnumeratedClass
    java_import com.hp.hpl.jena.ontology.FunctionalProperty
    java_import com.hp.hpl.jena.ontology.HasValueRestriction
    java_import com.hp.hpl.jena.ontology.Individual
    java_import com.hp.hpl.jena.ontology.IntersectionClass
    java_import com.hp.hpl.jena.ontology.InverseFunctionalProperty
    java_import com.hp.hpl.jena.ontology.MaxCardinalityQRestriction
    java_import com.hp.hpl.jena.ontology.MaxCardinalityRestriction
    java_import com.hp.hpl.jena.ontology.MinCardinalityQRestriction
    java_import com.hp.hpl.jena.ontology.MinCardinalityRestriction
    java_import com.hp.hpl.jena.ontology.ObjectProperty
    java_import com.hp.hpl.jena.ontology.OntClass
    java_import com.hp.hpl.jena.ontology.OntDocumentManager
    java_import com.hp.hpl.jena.ontology.OntModel
    java_import com.hp.hpl.jena.ontology.OntModelSpec
    java_import com.hp.hpl.jena.ontology.Ontology
    java_import com.hp.hpl.jena.ontology.OntProperty
    java_import com.hp.hpl.jena.ontology.OntResource
    java_import com.hp.hpl.jena.ontology.OntTools
    java_import com.hp.hpl.jena.ontology.Profile
    java_import com.hp.hpl.jena.ontology.ProfileRegistry
    java_import com.hp.hpl.jena.ontology.QualifiedRestriction
    java_import com.hp.hpl.jena.ontology.Restriction
    java_import com.hp.hpl.jena.ontology.SomeValuesFromRestriction
    java_import com.hp.hpl.jena.ontology.SymmetricProperty
    java_import com.hp.hpl.jena.ontology.TransitiveProperty
    java_import com.hp.hpl.jena.ontology.UnionClass
  end

  module TDB
    java_import com.hp.hpl.jena.tdb.TDB
    java_import com.hp.hpl.jena.tdb.TDBLoader
    java_import com.hp.hpl.jena.tdb.TDBFactory
  end
end