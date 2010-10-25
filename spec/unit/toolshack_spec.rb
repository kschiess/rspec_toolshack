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
  describe "<- .tempdir_for" do
    tempdir_for(:each, 'tempdir_for')
    subject { tempdir }
    
    it { should_not be_nil }
    it "should be a directory" do
      File.directory?(tempdir).should == true
    end 
    
    2.times do |i|
      # Create and clean a tempdir twice. There should be no junk left lying 
      # around.
      let(:tempdirs) { [] }
      
      context "when creating more than one temporary directory (#{i+1})" do
        tempdir_for(:each, 'tempdir_for')
        
        before(:each) { tempdirs << tempdir }
        
        it "should have at most one directory alive" do
          (tempdirs - Array(tempdir)).each do |path|
            File.exist?(path).should == false
          end
        end 
      end
    end
    
  end
end