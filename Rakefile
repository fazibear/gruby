# -*- ruby -*-
require 'rubygems'
require 'hoe'
require "#{File.dirname(__FILE__)}/lib/GRuby.rb"

ENV['VERSION'] = GRuby::VERSION

Hoe.new('GRuby', GRuby::VERSION) do |p|
  p.rubyforge_name = 'gruby'
  p.author = 'Michal Kalbarczyk (FaziBear)'
  p.email = 'fazibear@gmail.com'
  p.url = ['http://gruby.rubyforge.org', 'http://fazibear.prv.pl']
  p.summary = "Gadu-Gadu protocol implementation in Ruby language"
  p.description = "Gadu-Gadu protocol implementation in Ruby language"
  p.need_zip = true
  p.remote_rdoc_dir = ''
end

desc "Generate Manifest.new for dist"
task :manifest do
  File.open("Manifest.new", "wb") { |manifest|
    Dir["**/*"].each { |file|
      manifest.puts file  if File.file? file
    }
  }
end
