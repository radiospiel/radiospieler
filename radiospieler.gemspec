# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "radiospieler"
  s.version = "0.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["radiospiel"]
  s.date = "2012-04-05"
  s.description = "Some basics that your application could benefit from."
  s.email = "eno@open-lab.org"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "app.tmproj",
    "config/app.yml",
    "lib/core-extensions/array_ext.rb",
    "lib/core-extensions/benchmark-logger.rb",
    "lib/core-extensions/cgi_ext.rb",
    "lib/core-extensions/hash_ext.rb",
    "lib/core-extensions/object_ext.rb",
    "lib/core-extensions/string_ext.rb",
    "lib/core-extensions/string_without_accents.rb",
    "lib/core-extensions/tls.rb",
    "lib/core-extensions/uids.rb",
    "lib/core-extensions/uri_ext.rb",
    "lib/extensions/bitly.rb",
    "lib/extensions/http.rb",
    "lib/radiospieler.rb",
    "lib/radiospieler/radiospieler.rb",
    "lib/radiospieler/radiospieler/cache.rb",
    "lib/radiospieler/radiospieler/config.rb",
    "lib/radiospieler/radiospieler/logger.rb",
    "lib/radiospieler/radiospieler/root.rb",
    "radiospieler.gemspec",
    "script/watchr",
    "test/app_test.rb",
    "test/array_ext_test.rb",
    "test/bitlify_test.rb",
    "test/cache_test.rb",
    "test/cgi_ext_test.rb",
    "test/config.yml",
    "test/config_test.rb",
    "test/fixtures-vcr/bitly_limit_exceeded.yml",
    "test/fixtures-vcr/bitly_ok.yml",
    "test/fixtures-vcr/http_test.yml",
    "test/hash_ext_test.rb",
    "test/http_test.rb",
    "test/string_ext_test.rb",
    "test/test_helper.rb",
    "test/tls_test.rb",
    "test/uid_test.rb"
  ]
  s.homepage = "http://github.com/radiospiel/radiospieler"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.17"
  s.summary = "Application base code"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<pg>, [">= 0"])
      s.add_runtime_dependency(%q<sqlite3>, [">= 0"])
      s.add_runtime_dependency(%q<redis>, [">= 0"])
      s.add_runtime_dependency(%q<micro_sql>, [">= 0"])
      s.add_runtime_dependency(%q<simple_cache>, [">= 0"])
      s.add_runtime_dependency(%q<htmlentities>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<vcr>, [">= 0"])
      s.add_development_dependency(%q<webmock>, [">= 0"])
      s.add_development_dependency(%q<psych>, [">= 0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<ruby-debug19>, [">= 0"])
    else
      s.add_dependency(%q<pg>, [">= 0"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
      s.add_dependency(%q<redis>, [">= 0"])
      s.add_dependency(%q<micro_sql>, [">= 0"])
      s.add_dependency(%q<simple_cache>, [">= 0"])
      s.add_dependency(%q<htmlentities>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<vcr>, [">= 0"])
      s.add_dependency(%q<webmock>, [">= 0"])
      s.add_dependency(%q<psych>, [">= 0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<ruby-debug19>, [">= 0"])
    end
  else
    s.add_dependency(%q<pg>, [">= 0"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
    s.add_dependency(%q<redis>, [">= 0"])
    s.add_dependency(%q<micro_sql>, [">= 0"])
    s.add_dependency(%q<simple_cache>, [">= 0"])
    s.add_dependency(%q<htmlentities>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<vcr>, [">= 0"])
    s.add_dependency(%q<webmock>, [">= 0"])
    s.add_dependency(%q<psych>, [">= 0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<ruby-debug19>, [">= 0"])
  end
end
