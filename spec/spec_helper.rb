require 'mocha'
require "octoplex"

Dir[File.expand_path("../support/*.rb", __FILE__)].each { |file| require file }

RSpec.configure do |config|
  config.mock_with :mocha

  config.before(:all) do
  end
end
