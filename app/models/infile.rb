class Infile < ActiveRecord::Base
  attr_accessible :file_name, :file_size, :first_line, :parse_method

  has_many :datalines

  #
  # seeds.rb file gives a list of all the data files we want
  # to be looking at
  # This method reads in all the data files.
  #
  def self.read_list_of_files(list_file_name)

    file_list = File.new(list_file_name)


    file_list.each_line do  |line|
      @file_name, @parse_method = line.split("\t")
      @parse_method.chomp!      # get rid of trailing line feed

      a_file = File.new(@file_name, 'r')

      an_infile = Infile.new
      an_infile.parse_method = @parse_method
      an_infile.file_name = @file_name

      an_infile.file_size = File.size(@file_name)
      an_infile.first_line = a_file.readline.chomp

      # choudhary has an extra line at start "All di-Gly-lysines"
      if @parse_method == 'choudhary'
        an_infile.first_line = a_file.readline.chomp
      end

      an_infile.save

      @file_order = 0

      while !a_file.eof?
        @dataline = Dataline.new
        @dataline.tsv_string = a_file.readline.chomp
        @dataline.infile_id =  an_infile.id
        @file_order += 1
        @dataline.file_order = @file_order
        an_infile.datalines << @dataline
        @dataline.save
      end   # while

      an_infile.save

    end  # each_line

  end  # read_list_of_files



end   # Class Infile
