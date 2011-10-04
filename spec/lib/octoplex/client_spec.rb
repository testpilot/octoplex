require "spec_helper"
require "json"
require "octoplex/connection"

describe Octoplex::Client do
  before(:each) do
    Octoplex.discard_client!
    c = Faraday::Adapter::Test::Stubs.new

    test = Faraday.new do |builder|
      builder.adapter :test, c do |stub|
        stub.get('/user/keys') {[ 200, {'x-ratelimit-remaining' => '4999', 'x-ratelimit-limit' => '5000'}, "{}" ]}
        stub.post('/user/keys/123') {[ 200, {}, "{}" ]}
      end

      builder.use Faraday::Response::MultiJson
    end
    Octoplex::Connection.any_instance.stubs(:setup)
    Octoplex::Connection.any_instance.stubs(:conn).returns(test)
  end

  describe "rate limits" do
    it "should be updated after each request" do
      Octoplex.client.rate_limit.should == 0
      Octoplex.client.connection.get('/user/keys')
      Octoplex.client.rate_limit.should == 5000
    end

    it "should update remaining limit after request" do
      Octoplex.client.rate_limit_remaining.should == 0
      Octoplex.client.connection.get('/user/keys')
      Octoplex.client.rate_limit_remaining.should == 4999
    end
  end

  describe "API methods" do
    it "should delegate #get to connection" do
      Octoplex::Connection.any_instance.expects(:get).once.with('/user/keys')
      Octoplex.client.get('/user/keys')
    end

    it "should delegate #post to connection" do
      Octoplex::Connection.any_instance.expects(:post).once.with('/user/keys', {:key => '1233'})
      Octoplex.client.post('/user/keys', {:key => '1233'})
    end

    it "should delegate #put to connection" do
      Octoplex::Connection.any_instance.expects(:put).once.with('/user/keys', {:key => '1233'})
      Octoplex.client.put('/user/keys', {:key => '1233'})
    end

    it "should delegate #delete to connection" do
      Octoplex::Connection.any_instance.expects(:delete).once.with('/user/keys')
      Octoplex.client.delete('/user/keys')
    end
  end
end