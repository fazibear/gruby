# -*- ruby -*-
require 'rubygems'
require 'hoe'
require "#{File.dirname(__FILE__)}/lib/GRuby.rb"

ENV['version'] = GRuby::VERSION

Hoe.new('GRuby', GRuby::VERSION) do |p|
  p.rubyforge_name = 'gruby'
  p.author = 'fazibear'
  p.email = 'fazibear@gmail.com'
  p.summary = "Gadu-Gadu protocol implementation for Ruby language"
  p.description = p.paragraphs_of('README.txt', 2..5).join("\n\n")
  p.url = p.paragraphs_of('README.txt', 0).first.split(/\n/)[1..-1]
  p.changes = p.paragraphs_of('History.txt', 0..1).join("\n\n")
  p.need_zip = true
end

desc "Generate Manifest.new for dist"
task :manifest do
  File.open("Manifest.new", "wb") { |manifest|
    Dir["**/*"].each { |file|
      manifest.puts file  if File.file? file
    }
  }
end
