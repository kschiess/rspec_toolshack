require 'spec_helper'

require 'toolshack'

describe Toolshack do
  include Toolshack
  
  describe "<- .fixture_file" do
    
  end
  
  describe "<- .temporary_directory" do
    def call
      @tempdir_list ||= []
      
      temporary_directory('spec').tap { |t| @tempdir_list << t }
    end
    after(:each) { 
      @tempdir_list.each do |path|
        FileUtils.rm_rf path
      end
    }
    
    it "should return the name of a temporary directory" do
      File.directory?(call).should == true
    end
    it "should not return the same temporary directory twice" do
      call.should_not == call
    end  
  end
end