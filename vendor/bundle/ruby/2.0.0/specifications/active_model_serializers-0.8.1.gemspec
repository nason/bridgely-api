# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "active_model_serializers"
  s.version = "0.8.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jos\u{e9} Valim", "Yehuda Katz"]
  s.date = "2013-05-06"
  s.description = "Making it easy to serialize models for client-side use"
  s.email = ["jose.valim@gmail.com", "wycats@gmail.com"]
  s.homepage = "https://github.com/rails-api/active_model_serializers"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.6"
  s.summary = "Bringing consistency and object orientation to model serialization. Works great for client-side MVC frameworks!"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activemodel>, [">= 3.0"])
      s.add_development_dependency(%q<rails>, [">= 3.0"])
      s.add_development_dependency(%q<pry>, [">= 0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<coveralls>, [">= 0"])
    else
      s.add_dependency(%q<activemodel>, [">= 3.0"])
      s.add_dependency(%q<rails>, [">= 3.0"])
      s.add_dependency(%q<pry>, [">= 0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<coveralls>, [">= 0"])
    end
  else
    s.add_dependency(%q<activemodel>, [">= 3.0"])
    s.add_dependency(%q<rails>, [">= 3.0"])
    s.add_dependency(%q<pry>, [">= 0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<coveralls>, [">= 0"])
  end
end
