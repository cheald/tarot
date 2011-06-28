require 'spec_helper'

describe Tarot do
  before :all do
    @tarot = Tarot::Config.new("spec/data/test.yml", "development")
  end

  it "should load a YAML file" do
    @tarot.should_not == nil
    @tarot.yaml.should be_a(Hash)
  end

  it "should accept a default value for a key" do
    @tarot.get("bad key").should == nil
    @tarot.get("bad key", "with default").should == "with default"
  end  

  it "should walk a nested tree" do
    @tarot.get( "nested.tree.with.value" ).should == 42
    @tarot.get( "nested.tree.with.bad.key" ).should == nil
  end

  it "should accept an override environment" do
    @tarot.get("fizz").should == "buzz"
    @tarot.get("fizz", nil, "production").should == "bang"
  end
end