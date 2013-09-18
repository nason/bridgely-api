# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "debugger-ruby_core_source"
  s.version = "1.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mark Moseley", "Gabriel Horner"]
  s.date = "2013-06-27"
  s.description = "Provide Ruby core source files for C extensions that need them."
  s.email = "gabriel.horner@gmail.com"
  s.extra_rdoc_files = ["README.md"]
  s.files = ["README.md"]
  s.homepage = "http://github.com/cldwalker/debugger-ruby_core_source"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.6"
  s.summary = "Provide Ruby core source files"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<archive-tar-minitar>, [">= 0.5.2"])
      s.add_development_dependency(%q<rake>, ["~> 0.9.2"])
    else
      s.add_dependency(%q<archive-tar-minitar>, [">= 0.5.2"])
      s.add_dependency(%q<rake>, ["~> 0.9.2"])
    end
  else
    s.add_dependency(%q<archive-tar-minitar>, [">= 0.5.2"])
    s.add_dependency(%q<rake>, ["~> 0.9.2"])
  end
end
