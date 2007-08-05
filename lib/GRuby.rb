Dir[File.join(File.dirname(__FILE__), 'GRuby/**/*.rb')].sort.each { |lib| require lib }
class GRuby
    VERSION = '0.2.0'
end
