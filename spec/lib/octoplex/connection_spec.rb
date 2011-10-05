require "spec_helper"
require "json"
describe Octoplex::Connection do
  let(:user_key) {
    {
      :key => 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA2',
      :url => "https://api.github.com/user/keys/123",
      :title => "SSH Key",
      :id => 123
    }
  }

  let(:user_keys_payload) {
    keys = [
      user_key
    ]

    JSON.dump(keys)
  }

  before(:each) do
    c = Faraday::Adapter::Test::Stubs.new

    test = Faraday.new do |builder|
      builder.adapter :test, c do |stub|
        stub.get('/user/keys') {[ 200, {}, user_keys_payload ]}
        stub.get('/users/ivan/cloudist') {[ 200, {}, JSON.dump({:login => 'ivan'})]}
        stub.post('/user/keys/123') {[ 200, {}, JSON.dump(user_key) ]}
      end

      builder.use Faraday::Response::MultiJson
    end
    Octoplex::Connection.any_instance.stubs(:setup)
    Octoplex::Connection.any_instance.stubs(:conn).returns(test)
  end

  it "should handle a GET request to github and parse response" do
    conn = Octoplex::Connection.new
    conn.get('/user/keys').should be_a Array
  end

  it "should handle a POST request to github and parse response" do
    conn = Octoplex::Connection.new
    conn.post('/user/keys/123', {:key => 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA2'}).values.should == user_key.values
  end

  it "should return accept token as first argument" do
    conn = Octoplex::Connection.new(:token => '1234')
    conn.token.should == '1234'
  end

  describe "caching" do
    it "should cache each request and it's response" do
      conn = Octoplex::Connection.new(:token => '1234')
      conn.expects(:cached).with('/users/ivan/cloudist').returns({'login' => 'ivan'}).once

      conn.get('/users/ivan/cloudist').should == {'login' => 'ivan'}
      # This second request should hit cache
      # and avoid caching the resuult
      conn.expects(:cache).with('/users/ivan/cloudist', {'login' => 'ivan'}).never
      conn.get('/users/ivan/cloudist').should == {'login' => 'ivan'}
    end

    it "should not cache response if caching is disabled" do
      conn = Octoplex::Connection.new(:token => '1234', :enable_caching => false)
      conn.expects(:cached).with('/users/ivan/cloudist').never

      conn.get('/users/ivan/cloudist').should == {'login' => 'ivan'}
      # This second request should hit cache
      # and avoid caching the resuult
      conn.expects(:cache).with('/users/ivan/cloudist', {'login' => 'ivan'}).returns({'login' => 'ivan'}).once
      conn.get('/users/ivan/cloudist').should == {'login' => 'ivan'}
    end
  end
end
