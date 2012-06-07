# Note: important to get these in reverse dependency order
# Use mvn dependency:tree to show deps from the pom.xml

%w[
log4j-1.2.16.jar
slf4j-api-1.6.4.jar
slf4j-log4j12-1.6.4.jar
commons-codec-1.5.jar
httpclient-4.1.2.jar
httpcore-4.1.3.jar
jena-iri-0.9.1-SNAPSHOT.jar
xercesImpl-2.10.0.jar
xml-apis-1.4.01.jar
jena-core-2.7.1-SNAPSHOT.jar
jena-arq-2.9.1-SNAPSHOT.jar
jena-tdb-0.9.1-SNAPSHOT.jar
].each do |jar|
  require jar
end
