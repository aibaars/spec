require_relative '../spec_helper'
require_relative 'shared/verbose'

describe "The -W command line option" do
  before :each do
    @script = fixture __FILE__, "verbose.rb"
  end

  it "with 0 sets $VERBOSE to nil" do
    ruby_exe(@script, options: "-W0").chomp.should == "nil"
  end

  it "with 1 sets $VERBOSE to false" do
    ruby_exe(@script, options: "-W1").chomp.should == "false"
  end
end

describe "The -W command line option with 2" do
  it_behaves_like :command_line_verbose, "-W2"
end

ruby_version_is "2.7" do
  describe "The -W command line option with :no-deprecated" do
    it "suppresses deprecation warnings" do
      result = ruby_exe('$; = ""', args: '2>&1')
      result.should =~ /is deprecated/

      result = ruby_exe('$; = ""', options: '-W:no-deprecated', args: '2>&1')
      result.should == ""
    end
  end
end
