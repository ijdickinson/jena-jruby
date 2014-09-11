# Note: important to get these in reverse dependency order
# Use mvn dependency:tree to show deps from the pom.xml

%w[
log4j-config.jar
log4j-1.2.17.jar
slf4j-log4j12-1.7.6.jar
slf4j-api-1.7.6.jar
xml-apis-1.4.01.jar
xercesImpl-2.11.0.jar
jena-iri-1.1.0.jar
jena-core-2.12.0.jar
jcl-over-slf4j-1.7.6.jar
httpclient-cache-4.2.6.jar
jackson-annotations-2.3.0.jar
jackson-databind-2.3.3.jar
jackson-core-2.3.3.jar
jsonld-java-0.5.0.jar
commons-codec-1.6.jar
httpcore-4.2.5.jar
httpclient-4.2.6.jar
jena-arq-2.12.0.jar
jena-tdb-1.1.0.jar
].each do |jar|
  require jar
end
