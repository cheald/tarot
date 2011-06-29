require 'spec_helper'

describe Tarot do
  context "Given a single file" do
    before :all do
      @tarot = Tarot::Config.new("spec/data/test.yml", "development")
    end

    it "should load a YAML file from a string" do
      @tarot.should_not == nil
      @tarot.yaml.should be_a(Hash)
      @tarot.config_files.should == ["spec/data/test.yml"]
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

    it "should accept a method_missing chain" do
      @tarot.nested.tree.with.value.should == 42
      @tarot.nested.tree.with.bad_value(1234).should == 1234
      @tarot.fizz.should == "buzz"
      @tarot.fizz(nil, "production").should == "bang"
    end
  end

  context "Given multiple config files" do
    it "should produce a recursively merged hash when given multiple files to load" do
      @tarot = Tarot::Config.new(["spec/data/test.yml", "spec/data/recursive.yml"], "development")
      @tarot.get("foo").should == "fizzle"
      @tarot.get("mah").should == "rizzle"
      @tarot.get("fizz").should == "buzz"
    end
  end
end