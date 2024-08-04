# frozen_string_literal: true

require_relative "lib/iprog_export_model_to_xlsx/version"

Gem::Specification.new do |spec|
  spec.name = "iprog_export_model_to_xlsx"
  spec.version = IprogExportModelToXlsx::VERSION
  spec.authors = ["Jayson Presto"]
  spec.email = ["iprog21@jaysonpresto.me"]

  spec.summary = "A gem for exporting activerecord data to XLSX files."
  spec.description = "A gem for exporting activerecord data to XLSX files using the axlsx gem."
  spec.homepage = "https://github.com/iprog21/iprog_export_model_to_xlsx.git"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/iprog21/iprog_export_model_to_xlsx.git"
  spec.metadata["changelog_uri"] = "https://github.com/iprog21/iprog_export_model_to_xlsx/blob/master/CHANGELOG.md"
  spec.metadata["code_of_conduct_uri"] = "https://github.com/iprog21/iprog_export_model_to_xlsx/blob/main/CODE_OF_CONDUCT.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  File.basename(__FILE__)
  # spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
  #   ls.readlines("\x0", chomp: true).reject do |f|
  #     (f == gemspec) ||
  #       f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
  #   end
  # end
  spec.files  = Dir.glob("{lib/**/*,bin/*,README.md,LICENSE.txt}").reject { |file| file =~ /\.gem$/ }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "caxlsx", "~> 4.1.0"
  spec.add_runtime_dependency "caxlsx_rails", "~> 0.6.4"

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
