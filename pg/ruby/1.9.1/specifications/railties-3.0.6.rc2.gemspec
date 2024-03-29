# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{railties}
  s.version = "3.0.6.rc2"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{David Heinemeier Hansson}]
  s.date = %q{2011-03-30}
  s.description = %q{Rails internals: application bootup, plugins, generators, and rake tasks.}
  s.email = %q{david@loudthinking.com}
  s.homepage = %q{http://www.rubyonrails.org}
  s.rdoc_options = [%q{--exclude}, %q{.}]
  s.require_paths = [%q{lib}]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
  s.rubyforge_project = %q{rails}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Tools for creating, working with, and running Rails applications.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rake>, [">= 0.8.7"])
      s.add_runtime_dependency(%q<thor>, ["~> 0.14.4"])
      s.add_runtime_dependency(%q<activesupport>, ["= 3.0.6.rc2"])
      s.add_runtime_dependency(%q<actionpack>, ["= 3.0.6.rc2"])
    else
      s.add_dependency(%q<rake>, [">= 0.8.7"])
      s.add_dependency(%q<thor>, ["~> 0.14.4"])
      s.add_dependency(%q<activesupport>, ["= 3.0.6.rc2"])
      s.add_dependency(%q<actionpack>, ["= 3.0.6.rc2"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0.8.7"])
    s.add_dependency(%q<thor>, ["~> 0.14.4"])
    s.add_dependency(%q<activesupport>, ["= 3.0.6.rc2"])
    s.add_dependency(%q<actionpack>, ["= 3.0.6.rc2"])
  end
end
