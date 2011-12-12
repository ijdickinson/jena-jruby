require 'bundler'
require 'rake/testtask'

Bundler::GemHelper.install_tasks

####################################################
# Testing
####################################################

Rake::TestTask.new(:test) do |t|
    t.libs << "test" << "."
    t.test_files = FileList['test/*test.rb']
    # t.verbose = true
end

namespace :test do

  desc 'Measures test coverage'
  task :coverage do
    rm_f "profiling"
#    rcov = "rcov --rails --aggregate coverage.data --text-summary -Ilib"
    rcov = "rcov -I ./test -i '^lib/' -x 'rvm|\.js$|\.html$' --profile --sort coverage"
    system("#{rcov} test/*_test.rb")
    system("gnome-open profiling/index.html")
  end

end

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('lib/rdf_renderer/VERSION') ? File.read('lib/rdf_renderer/VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "RDF Renderer #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
