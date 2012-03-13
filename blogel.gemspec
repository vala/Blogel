$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "blogel/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "blogel"
  s.version     = Blogel::VERSION
  s.authors     = ["Valentin Ballestrino"]
  s.email       = ["vala@glyph.fr"]
  s.homepage    = "http://www.github.com/vala/blogel"
  s.summary     = "Lightweight blog engine for Rails"
  s.description = "Blogel is just a simple rails blog engine that's meant to drop a small blog with basical functionalities inside of a rails app, as a mountable engine"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.1"
  s.add_dependency "paperclip"
  s.add_dependency "kaminari"
  s.add_dependency "scoped_search"

  s.add_development_dependency "mysql2"
end
