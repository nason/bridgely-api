# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rails-api"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["Santiago Pastorino and Carlos Antonio da Silva"]
  s.date = "2013-04-01"
  s.description = "Rails::API is a subset of a normal Rails application,\n                         created for applications that don't require all\n                         functionality that a complete Rails application provides"
  s.email = ["<santiago@wyeworks.com>", "<carlosantoniodasilva@gmail.com>"]
  s.executables = ["rails-api"]
  s.files = ["bin/rails-api"]
  s.homepage = "https://github.com/spastorino/rails-api"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.6"
  s.summary = "Rails for API only Applications"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionpack>, [">= 3.2.11"])
      s.add_runtime_dependency(%q<railties>, [">= 3.2.11"])
      s.add_runtime_dependency(%q<tzinfo>, ["~> 0.3.31"])
      s.add_development_dependency(%q<rails>, [">= 3.2.11"])
    else
      s.add_dependency(%q<actionpack>, [">= 3.2.11"])
      s.add_dependency(%q<railties>, [">= 3.2.11"])
      s.add_dependency(%q<tzinfo>, ["~> 0.3.31"])
      s.add_dependency(%q<rails>, [">= 3.2.11"])
    end
  else
    s.add_dependency(%q<actionpack>, [">= 3.2.11"])
    s.add_dependency(%q<railties>, [">= 3.2.11"])
    s.add_dependency(%q<tzinfo>, ["~> 0.3.31"])
    s.add_dependency(%q<rails>, [">= 3.2.11"])
  end
end
