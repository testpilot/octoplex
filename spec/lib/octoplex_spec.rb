require "spec_helper"

describe Octoplex do
  describe "#connection" do
    it "should store a cached instance of Connection" do
      Octoplex.instance_variable_get("@connection").should be_nil
      Octoplex.connection.should be_a Octoplex::Connection
      Octoplex.instance_variable_get("@connection").should be_a Octoplex::Connection
    end
  end
end