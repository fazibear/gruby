Dir[File.join(File.dirname(__FILE__), 'GRuby/**/*.rb')].sort.each { |lib| require lib }
