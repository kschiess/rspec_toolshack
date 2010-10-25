
require 'tempfile'

# A collection of tools for my tests. These are things that I use all over the
# place and that I just don't want to write again. 
#
module Toolshack
  # Creates a temporary directory and returns its path to the caller. Note
  # that this can also be used in block style: 
  #
  #   temporary_directory     # => path 
  # 
  #   temporary_directory do |path|
  #     ... 
  #   end
  #
  # Please have a look at .managed_tempdir as well. 
  #
  def temporary_directory(base)
    tempfile = Tempfile.new(base)
    path = tempfile.path
    tempfile.close(true)
    
    FileUtils.mkdir(path)

    # Used as a block?
    if block_given?
      begin
        yield(path)
      ensure 
        FileUtils.rm_rf(path)
      end
      return
    end
    
    path
  end
  module_function :temporary_directory

  # Use this in rspec to create and manage a tempdir at the same time. Roughly
  # aequivalent to this: 
  #
  #   attr_reader :tempdir
  #   around(scope) { |example|
  #     temporary_directory do |path|
  #       @tempdir = path
  #       example.run
  #     end
  #   end
  # 
  def tempdir_for(scope, name=:tempdir)
    attr_reader name

    around(scope) { |example|
      temporary_directory do |path|
        instance_variable_set("@#{name}", path)
        example.run
      end
    }
  end
  module_function :tempdir_for
end
