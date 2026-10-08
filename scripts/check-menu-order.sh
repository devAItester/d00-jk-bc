#!/usr/bin/env bash
set -euo pipefail

ruby <<'RUBY'
require "yaml"

menu = YAML.load_file("_data/menu.yml")
abort "Menu data must be a mapping" unless menu.is_a?(Hash)

menu.each do |dir, names|
  abort "Menu entry for #{dir.inspect} must be an array" unless names.is_a?(Array)
  abort "Duplicate _menu entry in #{dir.inspect}" unless names.uniq.length == names.length

  names.each do |name|
    abort "Invalid menu entry #{dir.inspect}: #{name.inspect}" unless name.is_a?(String) && name.match?(/\A[^\n]+\.md\z/)
    path = dir.to_s.empty? ? name : File.join(dir.to_s, name)
    abort "Menu entry does not exist: #{path}" unless File.file?(path)
  end
end

expected = ["tests.md", "navigation.md"]
actual = menu.fetch("development")
abort "development menu order failed: #{actual.inspect}" unless actual == expected

puts "Menu order data tests OK."
RUBY
