# frozen_string_literal: true

require_relative "lib/permafrost/version"

Gem::Specification.new do |spec|
  spec.name          = "permafrost"
  spec.version       = Permafrost::VERSION
  spec.authors       = ["Pedro Costa"]
  spec.email         = ["pedro@subvisual.com"]

  spec.summary       = "Freeze the environment in a given state."
  spec.description   = <<~DESCRIPTION
    Environment variables are a standard way for configuring applications in
    production. It allows for quickly changing the configuration, and avoids
    having to introduce secrets in the code.

    When testing code that relies on environment variables, it becomes
    problematic to mock the environment, and even more to clean up afterwards.

    Permafrost allows you to define a limited scope where the environment is
    set as you decide, returning it to its original state afterwards.
  DESCRIPTION
  spec.homepage = "https://github.com/subvisual/permafrost"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/subvisual/permafrost"
  spec.metadata["changelog_uri"] = "https://github.com/subvisual/permafrost/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.start_with?("spec") }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
