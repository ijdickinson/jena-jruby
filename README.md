# Gem wrapper for Apache Jena

This Gem provides convenience access to the [Apache Jena](http://jena.apache.org)
RDF platform. Jena is a widely used Java platform for parsing, storing, manipulating,
querying and publishing semantic web data and linked data. This gem provides a single
dependency so that JRuby programs can access all of the capabilities of Jena, including TDB,
conveniently from JRuby.

This gem provides the following benefits:

* a single dependency which includes all of the `.jar` files for the latest release
of Jena (currently 2.12.0) including TDB.

* import of some of the key classes used by Jena-based programs into a `Jena::`
module, to make code more compact

* some additional utility and convenience methods

## Using the gem

Once installed, just add to your code:

    require 'jena_jruby'

or add a suitable dependency to your bundle spec.

## Access to Jena from Java

Create a model:

    m = Jena::Core::ModelFactory.create_default_model

(note that JRuby automagically converts Java CamelCase names to Ruby lower_case names)

Add a statement:

    jruby-1.6.5 :003 > m = Jena::Core::ModelFactory.create_default_model
     => #<Java::ComHpHplJenaRdfModelImpl::ModelCom:0x135a4815>
    jruby-1.6.5 :004 > s = Jena::Core::ResourceFactory.create_resource "http://example.org/s"
     => #<Java::ComHpHplJenaRdfModelImpl::ResourceImpl:0x7b0f62cb>
    jruby-1.6.5 :005 > o = Jena::Core::ResourceFactory.create_resource "http://example.org/o"
     => #<Java::ComHpHplJenaRdfModelImpl::ResourceImpl:0x4879c985>
    jruby-1.6.5 :006 > p = Jena::Core::ResourceFactory.createProperty "http://example.org/p"
     => #<Java::ComHpHplJenaRdfModelImpl::PropertyImpl:0x3f7cd159>
    jruby-1.6.5 :007 > m.add s,p,o
     => #<Java::ComHpHplJenaRdfModelImpl::ModelCom:0x135a4815>
    jruby-1.6.5 :009 > m.toString
     => "<ModelCom   {http://example.org/s @http://example.org/p http://example.org/o} | >"

## Building and installing the gem

Since `jena-jruby` now includes TDB, the easiest way to get the full set of jars necessary
to support Jena is to use Maven to list the dependencies declared in the TDB `pom.xml`.
For convenience, this is packaged in a bash script:

    ian@ian-desktop $ bin/update_jars_maven 
    Changing to temp directory 
    ~/workspace/jena-jruby/temp ~/workspace/jena-jruby
    Fetching TDB version 2.12.0
    A    jena-tdb/bin-test
    A    jena-tdb/src
    ... lots more of these ...
     U   jena-tdb
    Checked out revision 1624415.
    Cleaning old versions and recompiling ...
    [INFO] Scanning for projects...
    [WARNING] 
    [WARNING] Some problems were encountered while building the effective model for org.apache.jena:jena-tdb:jar:1.1.0
    [WARNING] 'reporting.plugins.plugin.version' for org.apache.maven.plugins:maven-surefire-report-plugin is missing. @ org.apache.jena:jena-parent:10, /home/ian/.m2/repository/org/apache/jena/jena-parent/10/jena-parent-10.pom, line 521, column 15
    [WARNING] 
    [WARNING] It is highly recommended to fix these problems because they threaten the stability of your build.
    [WARNING] 
    [WARNING] For this reason, future Maven versions might no longer support building such malformed projects.
    [WARNING] 
    [INFO]                                                                         
    [INFO] ------------------------------------------------------------------------
    [INFO] Building Apache Jena - TDB (Native Triple Store) 1.1.0
    [INFO] ------------------------------------------------------------------------
    [INFO] 
    [INFO] --- maven-clean-plugin:2.5:clean (default-clean) @ jena-tdb ---
    [INFO] 
    [INFO] --- maven-enforcer-plugin:1.3.1:enforce (enforce) @ jena-tdb ---
    [INFO] 
    [INFO] --- maven-enforcer-plugin:1.3.1:enforce (enforce-java) @ jena-tdb ---
    [INFO] 
    [INFO] --- maven-remote-resources-plugin:1.5:process (default) @ jena-tdb ---
    [INFO] 
    [INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ jena-tdb ---
    [INFO] Using 'UTF-8' encoding to copy filtered resources.
    [INFO] Copying 0 resource
    [INFO] Copying 1 resource
    [INFO] Copying 3 resources
    [INFO] 
    [INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ jena-tdb ---
    [INFO] Changes detected - recompiling the module!
    [INFO] Compiling 263 source files to /home/ian/workspace/jena-jruby/temp/jena-tdb/target/classes
    [INFO] 
    [INFO] --- maven-resources-plugin:2.6:testResources (default-testResources) @ jena-tdb ---
    [INFO] Using 'UTF-8' encoding to copy filtered resources.
    [INFO] Copying 0 resource
    [INFO] Copying 3 resources
    [INFO] 
    [INFO] --- maven-compiler-plugin:3.1:testCompile (default-testCompile) @ jena-tdb ---
    [INFO] Changes detected - recompiling the module!
    [INFO] Compiling 129 source files to /home/ian/workspace/jena-jruby/temp/jena-tdb/target/test-classes
    [INFO] 
    [INFO] --- maven-surefire-plugin:2.16:test (default-test) @ jena-tdb ---
    [INFO] Tests are skipped.
    [INFO] 
    [INFO] --- maven-jar-plugin:2.4:jar (default-jar) @ jena-tdb ---
    [INFO] Building jar: /home/ian/workspace/jena-jruby/temp/jena-tdb/target/jena-tdb-1.1.0.jar
    [INFO] 
    [INFO] --- maven-site-plugin:3.3:attach-descriptor (attach-descriptor) @ jena-tdb ---
    [INFO] 
    [INFO] --- maven-source-plugin:2.2.1:jar-no-fork (attach-sources) @ jena-tdb ---
    [INFO] Building jar: /home/ian/workspace/jena-jruby/temp/jena-tdb/target/jena-tdb-1.1.0-sources.jar
    [INFO] 
    [INFO] --- maven-source-plugin:2.2.1:test-jar-no-fork (attach-sources-test) @ jena-tdb ---
    [INFO] Building jar: /home/ian/workspace/jena-jruby/temp/jena-tdb/target/jena-tdb-1.1.0-test-sources.jar
    [INFO] 
    [INFO] --- maven-jar-plugin:2.4:test-jar (default) @ jena-tdb ---
    [INFO] Building jar: /home/ian/workspace/jena-jruby/temp/jena-tdb/target/jena-tdb-1.1.0-tests.jar
    [INFO] 
    [INFO] --- maven-javadoc-plugin:2.9.1:jar (attach-javadocs) @ jena-tdb ---
    [INFO] Building jar: /home/ian/workspace/jena-jruby/temp/jena-tdb/target/jena-tdb-1.1.0-javadoc.jar
    [INFO] 
    [INFO] --- maven-install-plugin:2.5.1:install (default-install) @ jena-tdb ---
    [INFO] Installing /home/ian/workspace/jena-jruby/temp/jena-tdb/target/jena-tdb-1.1.0.jar to /home/ian/.m2/repository/org/apache/jena/jena-tdb/1.1.0/jena-tdb-1.1.0.jar
    [INFO] Installing /home/ian/workspace/jena-jruby/temp/jena-tdb/pom.xml to /home/ian/.m2/repository/org/apache/jena/jena-tdb/1.1.0/jena-tdb-1.1.0.pom
    [INFO] Installing /home/ian/workspace/jena-jruby/temp/jena-tdb/target/jena-tdb-1.1.0-sources.jar to /home/ian/.m2/repository/org/apache/jena/jena-tdb/1.1.0/jena-tdb-1.1.0-sources.jar
    [INFO] Installing /home/ian/workspace/jena-jruby/temp/jena-tdb/target/jena-tdb-1.1.0-test-sources.jar to /home/ian/.m2/repository/org/apache/jena/jena-tdb/1.1.0/jena-tdb-1.1.0-test-sources.jar
    [INFO] Installing /home/ian/workspace/jena-jruby/temp/jena-tdb/target/jena-tdb-1.1.0-tests.jar to /home/ian/.m2/repository/org/apache/jena/jena-tdb/1.1.0/jena-tdb-1.1.0-tests.jar
    [INFO] Installing /home/ian/workspace/jena-jruby/temp/jena-tdb/target/jena-tdb-1.1.0-javadoc.jar to /home/ian/.m2/repository/org/apache/jena/jena-tdb/1.1.0/jena-tdb-1.1.0-javadoc.jar
    [INFO] ------------------------------------------------------------------------
    [INFO] BUILD SUCCESS
    [INFO] ------------------------------------------------------------------------
    [INFO] Total time: 17.565s
    [INFO] Finished at: Thu Sep 11 23:43:16 BST 2014
    [INFO] Final Memory: 35M/366M
    [INFO] ------------------------------------------------------------------------
    Collecting dependencies ...
    [INFO] Scanning for projects...
    [WARNING] 
    [WARNING] Some problems were encountered while building the effective model for org.apache.jena:jena-tdb:jar:1.1.0
    [WARNING] 'reporting.plugins.plugin.version' for org.apache.maven.plugins:maven-surefire-report-plugin is missing. @ org.apache.jena:jena-parent:10, /home/ian/.m2/repository/org/apache/jena/jena-parent/10/jena-parent-10.pom, line 521, column 15
    [WARNING] 
    [WARNING] It is highly recommended to fix these problems because they threaten the stability of your build.
    [WARNING] 
    [WARNING] For this reason, future Maven versions might no longer support building such malformed projects.
    [WARNING] 
    [INFO]                                                                         
    [INFO] ------------------------------------------------------------------------
    [INFO] Building Apache Jena - TDB (Native Triple Store) 1.1.0
    [INFO] ------------------------------------------------------------------------
    [INFO] 
    [INFO] --- maven-dependency-plugin:2.8:copy-dependencies (default-cli) @ jena-tdb ---
    [INFO] Copying jena-iri-1.1.0.jar to /home/ian/workspace/jena-jruby/temp/jena-tdb/target/dependency/jena-iri-1.1.0.jar
    [INFO] Copying slf4j-api-1.7.6.jar to /home/ian/workspace/jena-jruby/temp/jena-tdb/target/dependency/slf4j-api-1.7.6.jar
    [INFO] Copying log4j-1.2.17.jar to /home/ian/workspace/jena-jruby/temp/jena-tdb/target/dependency/log4j-1.2.17.jar
    [INFO] Copying junit-4.11.jar to /home/ian/workspace/jena-jruby/temp/jena-tdb/target/dependency/junit-4.11.jar
    [INFO] Copying xercesImpl-2.11.0.jar to /home/ian/workspace/jena-jruby/temp/jena-tdb/target/dependency/xercesImpl-2.11.0.jar
    [INFO] Copying xml-apis-1.4.01.jar to /home/ian/workspace/jena-jruby/temp/jena-tdb/target/dependency/xml-apis-1.4.01.jar
    [INFO] Copying jena-arq-2.12.0.jar to /home/ian/workspace/jena-jruby/temp/jena-tdb/target/dependency/jena-arq-2.12.0.jar
    [INFO] Copying jsonld-java-0.5.0.jar to /home/ian/workspace/jena-jruby/temp/jena-tdb/target/dependency/jsonld-java-0.5.0.jar
    [INFO] Copying jena-core-2.12.0-tests.jar to /home/ian/workspace/jena-jruby/temp/jena-tdb/target/dependency/jena-core-2.12.0-tests.jar
    [INFO] Copying slf4j-log4j12-1.7.6.jar to /home/ian/workspace/jena-jruby/temp/jena-tdb/target/dependency/slf4j-log4j12-1.7.6.jar
    [INFO] Copying httpcore-4.2.5.jar to /home/ian/workspace/jena-jruby/temp/jena-tdb/target/dependency/httpcore-4.2.5.jar
    [INFO] Copying jcl-over-slf4j-1.7.6.jar to /home/ian/workspace/jena-jruby/temp/jena-tdb/target/dependency/jcl-over-slf4j-1.7.6.jar
    [INFO] Copying jackson-core-2.3.3.jar to /home/ian/workspace/jena-jruby/temp/jena-tdb/target/dependency/jackson-core-2.3.3.jar
    [INFO] Copying hamcrest-core-1.3.jar to /home/ian/workspace/jena-jruby/temp/jena-tdb/target/dependency/hamcrest-core-1.3.jar
    [INFO] Copying httpclient-4.2.6.jar to /home/ian/workspace/jena-jruby/temp/jena-tdb/target/dependency/httpclient-4.2.6.jar
    [INFO] Copying jena-core-2.12.0.jar to /home/ian/workspace/jena-jruby/temp/jena-tdb/target/dependency/jena-core-2.12.0.jar
    [INFO] Copying jackson-databind-2.3.3.jar to /home/ian/workspace/jena-jruby/temp/jena-tdb/target/dependency/jackson-databind-2.3.3.jar
    [INFO] Copying jackson-annotations-2.3.0.jar to /home/ian/workspace/jena-jruby/temp/jena-tdb/target/dependency/jackson-annotations-2.3.0.jar
    [INFO] Copying jena-arq-2.12.0-tests.jar to /home/ian/workspace/jena-jruby/temp/jena-tdb/target/dependency/jena-arq-2.12.0-tests.jar
    [INFO] Copying commons-codec-1.6.jar to /home/ian/workspace/jena-jruby/temp/jena-tdb/target/dependency/commons-codec-1.6.jar
    [INFO] Copying httpclient-cache-4.2.6.jar to /home/ian/workspace/jena-jruby/temp/jena-tdb/target/dependency/httpclient-cache-4.2.6.jar
    [INFO] ------------------------------------------------------------------------
    [INFO] BUILD SUCCESS
    [INFO] ------------------------------------------------------------------------
    [INFO] Total time: 2.306s
    [INFO] Finished at: Thu Sep 11 23:43:20 BST 2014
    [INFO] Final Memory: 14M/216M
    [INFO] ------------------------------------------------------------------------
    Changing directory back

You can then generate a list of the downloaded `jar`s for inclusion in the project; this list is pre-loaded in `lib/jena_jruby/jars.rb`:

    ian@ian-desktop $ bin/list-dependencies 
    ~/workspace/jena-jruby/temp/jena-tdb ~/workspace/jena-jruby
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

To build the gem itself:

    ian@ian-desktop $ rake build
    jena-jruby 0.6.0 built to pkg/jena-jruby-0.6.0-java.gem.

To run the tests:

    ian@ian-desktop $ bundle exec rake test
    Run options: --seed 45483

    # Running:

    ................

    Finished in 0.351000s, 45.5840 runs/s, 142.4501 assertions/s.

    16 runs, 50 assertions, 0 failures, 0 errors, 0 skips
