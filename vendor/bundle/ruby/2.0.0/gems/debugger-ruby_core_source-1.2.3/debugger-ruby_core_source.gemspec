# -*- encoding: utf-8 -*-
require 'rubygems' unless defined? Gem
require File.dirname(__FILE__) + "/lib/debugger/ruby_core_source/version"

Gem::Specification.new do |s|
  s.name = "debugger-ruby_core_source"
  s.version = Debugger::RubyCoreSource::VERSION
  s.authors = ["Mark Moseley", "Gabriel Horner"]
  s.email = "gabriel.horner@gmail.com"
  s.homepage = "http://github.com/cldwalker/debugger-ruby_core_source"
  s.summary = %q{Provide Ruby core source files}
  s.description = %q{Provide Ruby core source files for C extensions that need them.}
  s.required_rubygems_version = ">= 1.3.6"
  s.extra_rdoc_files = [ "README.md"]
  s.files = Dir["#{File.dirname(__FILE__)}/lib/**/*{.rb,inc,h}"] +
    Dir["#{File.dirname(__FILE__)}/{Rakefile,README.md,CHANGELOG.md,debugger-ruby_core_source.gemspec}"]
  s.add_development_dependency "archive-tar-minitar", ">= 0.5.2"
  s.add_development_dependency 'rake', '~> 0.9.2'
end
