# Gem wrapper for Apache Jena

This Gem provides convenience access to the [Apache Jena](http://incubator.apache.org/jena)
RDF platform. Jena is a widely used Java platform for parsing, storing, manipulating,
querying and publishing semantic web data and linked data. This Gem provides a single
dependency so that JRuby programs can access all of the main capabilities of Jena
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

    m = Jena::ModelFactory.create_default_model

(note that JRuby automagically converts Java CamelCase names to Ruby lower_case names)

## Building and installing the gem

