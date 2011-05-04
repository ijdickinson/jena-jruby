# Gem wrapper for Apache Jena

This Gem provides convenience access to the [Apache Jena](http://incubator.apache.org/jena)
RDF platform. Jena is a widely used Java platform for parsing, storing, manipulating,
querying and publishing semantic web data and linked data. This Gem provides a single
dependency so that JRuby programs can access all of the main capabilities of Jena
conveniently from Ruby.

This gem provides the following benefits:

* a single dependency which includes all of the `.jar` files for the latest release
of Jena (currently 2.6.4)

* import of some of the key classes used by Jena-based programs into a `Jena::`
module, to make code more compact

* some additional utility and convenience methods

## Using the gem

Once installed, just add to your code:

    require 'jruby_jena'

or add a suitable dependency to your bundle spec.

## Building and installing the gem

To download and extract the current Jena `.jar` files into a local `download` directory,
run the `update_jena` script from the command line:

    ian@ian-desktop $ bin/update_jena
    Downloading Jena 2.6.4...
    Writing lib/jruby_jena/jars.rb ...

This does require `unzip` to be on the path; this is normal on Linux, patches are
welcome from Windows users. Once the Jena `.jar` files are in place, install the gem
with rake:

    ian@ian-desktop $ rake install
    (in /home/ian/workspace/jruby-jena)
    jruby-jena 2.6.4 built to pkg/jruby-jena-2.6.4.gem
    jruby-jena (2.6.4) installed
