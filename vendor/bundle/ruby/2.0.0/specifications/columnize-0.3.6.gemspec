# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "columnize"
  s.version = "0.3.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["R. Bernstein"]
  s.date = "2011-12-16"
  s.description = "\nIn showing a long lists, sometimes one would prefer to see the value\narranged aligned in columns. Some examples include listing methods\nof an object or debugger commands. \nSee Examples in the rdoc documentation for examples.\n"
  s.email = "rockyb@rubyforge.net"
  s.extra_rdoc_files = ["README.md", "lib/columnize.rb", "COPYING"]
  s.files = ["README.md", "lib/columnize.rb", "COPYING"]
  s.homepage = "https://github.com/rocky/columnize"
  s.licenses = ["Ruby", "GPL2"]
  s.rdoc_options = ["--main", "README", "--title", "Columnize 0.3.6 Documentation"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.2")
  s.rubyforge_project = "columnize"
  s.rubygems_version = "2.0.6"
  s.summary = "Module to format an Array as an Array of String aligned in columns"
end
