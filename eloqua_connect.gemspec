# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "eloqua_connect"
  s.version = "0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Martin Becker"]
  s.date = "2013-12-05"
  s.description = "push data to eloqua with model like behavior"
  s.email = "mbeckerwork@gmail.com"
  s.extra_rdoc_files = ["README.md", "lib/eloqua_connect.rb", "lib/main/base.rb", "lib/main/config.rb", "lib/main/model.rb", "lib/main/modelsetup.rb", "lib/main/modules/fields.rb"]
  s.files = ["LICENCE/GPL-2", "Manifest", "README.md", "Rakefile", "eloqua_connect.gemspec", "lib/eloqua_connect.rb", "lib/main/base.rb", "lib/main/config.rb", "lib/main/model.rb", "lib/main/modelsetup.rb", "lib/main/modules/fields.rb"]
  s.homepage = "https://github.com/Thermatix/eloqua_connect"
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Eloqua_connect", "--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "eloqua_connect"
  s.rubygems_version = "2.0.6"
  s.summary = "push data to eloqua with model like behavior"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<eloqua_api>, ["~> 0.0.7"])
    else
      s.add_dependency(%q<eloqua_api>, ["~> 0.0.7"])
    end
  else
    s.add_dependency(%q<eloqua_api>, ["~> 0.0.7"])
  end
end
