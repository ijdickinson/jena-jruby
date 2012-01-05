# Gem wrapper for Apache Jena

This Gem provides convenience access to the [Apache Jena](http://incubator.apache.org/jena)
RDF platform. Jena is a widely used Java platform for parsing, storing, manipulating,
querying and publishing semantic web data and linked data. This gem provides a single
dependency so that JRuby programs can access all of the capabilities of Jena, including TDB,
conveniently from JRuby.

This gem provides the following benefits:

* a single dependency which includes all of the `.jar` files for the latest release
of Jena (currently 2.7.0) and TDB (currently 0.9.0)

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

    ian@rowan-15 $ export JENA_TDB_ROOT=~/whereever/you/have/the/tdb/source
    # note: defaults to ~/workspace/apache-jena-tdb

    ian@rowan-15 $ cd ~/workspace/jena-jruby/
    ian@rowan-15 $ bin/update_jars_maven
    Changing to TDB directory /home/ian/workspace/apache-jena-tdb
    ~/workspace/apache-jena-tdb ~/workspace/jena-jruby
    Cleaning old versions and recompiling ...
    [INFO] Scanning for projects...
    [INFO] ------------------------------------------------------------------------
    [INFO] Building TDB
    [INFO]    task-segment: [clean, install]
    [INFO] ------------------------------------------------------------------------
      .. lots of maven output ..
    [INFO] ------------------------------------------------------------------------
    [INFO] BUILD SUCCESSFUL
    [INFO] ------------------------------------------------------------------------
    [INFO] Total time: 17 seconds
    [INFO] Finished at: Thu Jan 05 00:18:09 GMT 2012
    [INFO] Final Memory: 68M/718M
    [INFO] ------------------------------------------------------------------------
    Collecting dependencies ...
    [INFO] Scanning for projects...
    [INFO] Searching repository for plugin with prefix: 'dependency'.
    [INFO] ------------------------------------------------------------------------
    [INFO] Building TDB
    [INFO]    task-segment: [dependency:copy-dependencies]
    [INFO] ------------------------------------------------------------------------
    [INFO] [dependency:copy-dependencies {execution: default-cli}]
    [INFO] Copying icu4j-3.4.4.jar to /home/ian/workspace/apache-jena-tdb/target/dependency/icu4j-3.4.4.jar
      .. more maven output ..
    [INFO] ------------------------------------------------------------------------
    [INFO] BUILD SUCCESSFUL
    [INFO] ------------------------------------------------------------------------
    [INFO] Total time: 2 seconds
    [INFO] Finished at: Thu Jan 05 00:18:12 GMT 2012
    [INFO] Final Memory: 35M/349M
    [INFO] ------------------------------------------------------------------------
    ~/workspace/jena-jruby
    Changing directory back to /home/ian/workspace/jena-jruby
    Copying deps to ./javalib
    Creating log4j config

    ian@rowan-15 $ rake build
    rake/rdoctask is deprecated.  Use rdoc/task instead (in RDoc 2.4.2+)
    jena-jruby 0.3.0 built to pkg/jena-jruby-0.3.0-java.gem
