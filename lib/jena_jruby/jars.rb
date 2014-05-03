# Note: important to get these in reverse dependency order
# Use mvn dependency:tree to show deps from the pom.xml

%w[
commons-codec-1.6.jar
httpclient-4.2.3.jar
httpcore-4.2.2.jar
jcl-over-slf4j-1.6.4.jar
log4j-1.2.16.jar
slf4j-api-1.6.4.jar
slf4j-log4j12-1.6.4.jar
xercesImpl-2.11.0.jar
xml-apis-1.4.01.jar
jena-core-2.11.1.jar
jena-iri-1.0.1.jar
jena-arq-2.11.1.jar
jena-tdb-1.0.1.jar
].each do |jar|
  require jar
end
