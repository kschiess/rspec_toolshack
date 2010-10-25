require "rubygems"

require "rake/gempackagetask"
require "rake/rdoctask"

require 'rspec'
require 'rspec/core/rake_task'

Rspec::Core::RakeTask.new
task :default => :spec 

spec = Gem::Specification.new do |s|

  # Change these as appropriate
  s.name              = "rspec_toolshack"
  s.version           = "0.1.0"
  s.summary           = "A collection of tools for rspec testing."
  s.author            = "Kaspar Schiess"
  s.email             = "eule@space.ch"

  s.has_rdoc          = true

  # Add any extra files to include in the gem
  s.files             = %w(Gemfile README) + Dir.glob("{**/*}")

  # If you want to depend on other gems, add them here, along with any
  # relevant versions
  # s.add_dependency("some_other_gem", "~> 0.1.0")

  # If your tests use any gems, include them here
  # s.add_development_dependency("mocha") # for example
end

# This task actually builds the gem. We also regenerate a static
# .gemspec file, which is useful if something (i.e. GitHub) will
# be automatically building a gem for this project. If you're not
# using GitHub, edit as appropriate.
#
# To publish your gem online, install the 'gemcutter' gem; Read more 
# about that here: http://gemcutter.org/pages/gem_docs
Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "Build the gemspec file #{spec.name}.gemspec"
task :gemspec do
  file = File.dirname(__FILE__) + "/#{spec.name}.gemspec"
  File.open(file, "w") {|f| f << spec.to_ruby }
end

task :package => :gemspec

# Generate documentation
Rake::RDocTask.new do |rd|
  rd.main = "README"
  rd.rdoc_files.include("README", "lib/**/*.rb")
  rd.rdoc_dir = "rdoc"
end

desc 'Clear out RDoc and generated packages'
task :clean => [:clobber_rdoc, :clobber_package] do
  rm "#{spec.name}.gemspec"
end
