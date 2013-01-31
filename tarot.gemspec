# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "tarot/version"

Gem::Specification.new do |s|
  s.name        = "tarot"
  s.version     = Tarot::VERSION
  s.authors     = ["Chris Heald"]
  s.email       = ["cheald@gmail.com"]
  s.homepage    = "https://github.com/cheald/tarot"
  s.summary     = %q{Tarot is a small, concise configuration library for Rails apps.}
  s.description = %q{Tarot is a small, concise configuration library for Rails apps.}

  s.signing_key = '/home/chris/.gemcert/gem-private_key.pem'
  s.cert_chain  = ['gem-public_cert.pem']

  s.add_dependency('activesupport')

  s.rubyforge_project = "tarot"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
