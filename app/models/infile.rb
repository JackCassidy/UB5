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
      a_file = File.new(@file_name, 'r')

      an_infile = Infile.new
      an_infile.parse_method = @parse_method
      an_infile.file_name = @file_name

      an_infile.file_size = File.size(@file_name)
      an_infile.first_line = a_file.readline.chomp

      while !a_file.eof?
        @dataline = Dataline.new
        @dataline.tsv_string = a_file.readline.chomp
        an_infile.datalines << @dataline
        @dataline.save

        Peptide.parse_dataline(@dataline)
      end   # while

      an_infile.save

    end  # each_line

  end  # read_list_of_files

end
