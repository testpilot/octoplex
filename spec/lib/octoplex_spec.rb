require "spec_helper"

describe Octoplex do
  describe "#connection" do
    it "should store a cached instance of Client" do
      Octoplex.instance_variable_get("@client").should be_nil
      Octoplex.client.should be_a Octoplex::Client
      Octoplex.instance_variable_get("@client").should be_a Octoplex::Client
    end
  end
end
