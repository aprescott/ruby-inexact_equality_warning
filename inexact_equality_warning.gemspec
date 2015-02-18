Gem::Specification.new do |gem|
  gem.name          = "inexact_equality_warning"
  gem.version       = "0.0.2"
  gem.authors       = ["Adam Prescott"]
  gem.email         = ["adam@aprescott.com"]
  gem.description   = "Warn when comparing floats for equality."
  gem.summary       = "You do not want to compare floating point numbers for equality."
  gem.homepage      = "https://github.com/aprescott/ruby-inexact_equality_warning"

  gem.files         = Dir["{lib/**/*,spec/**/*,*.gemspec}"] + %w[.rspec .travis.yml LICENSE Gemfile README.md]
  gem.test_files    = Dir["spec/*"]
  gem.require_path  = "lib"
  gem.licenses      = ["MIT"]

  gem.required_ruby_version = ">= 2.0.0"

  gem.add_development_dependency("rspec", ">= 3.0")
end
