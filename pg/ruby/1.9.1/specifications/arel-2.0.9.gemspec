# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{arel}
  s.version = "2.0.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Aaron Patterson}, %q{Bryan Halmkamp}, %q{Emilio Tagua}, %q{Nick Kallen}]
  s.date = %q{2011-02-25}
  s.description = %q{Arel is a Relational Algebra for Ruby. It 1) simplifies the generation complex of SQL queries and it 2) adapts to various RDBMS systems. It is intended to be a framework framework; that is, you can build your own ORM with it, focusing on innovative object and collection modeling as opposed to database compatibility and query generation.}
  s.email = [%q{aaron@tenderlovemaking.com}, %q{bryan@brynary.com}, %q{miloops@gmail.com}, %q{nick@example.org}]
  s.extra_rdoc_files = [%q{History.txt}, %q{MIT-LICENSE.txt}, %q{Manifest.txt}, %q{README.markdown}]
  s.files = [%q{History.txt}, %q{MIT-LICENSE.txt}, %q{Manifest.txt}, %q{README.markdown}]
  s.homepage = %q{http://github.com/rails/arel}
  s.rdoc_options = [%q{--main}, %q{README.markdown}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{arel}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Arel is a Relational Algebra for Ruby}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<minitest>, [">= 2.0.0"])
      s.add_development_dependency(%q<hoe>, [">= 2.1.0"])
      s.add_development_dependency(%q<minitest>, [">= 1.6.0"])
      s.add_development_dependency(%q<hoe>, [">= 2.9.1"])
    else
      s.add_dependency(%q<minitest>, [">= 2.0.0"])
      s.add_dependency(%q<hoe>, [">= 2.1.0"])
      s.add_dependency(%q<minitest>, [">= 1.6.0"])
      s.add_dependency(%q<hoe>, [">= 2.9.1"])
    end
  else
    s.add_dependency(%q<minitest>, [">= 2.0.0"])
    s.add_dependency(%q<hoe>, [">= 2.1.0"])
    s.add_dependency(%q<minitest>, [">= 1.6.0"])
    s.add_dependency(%q<hoe>, [">= 2.9.1"])
  end
end
