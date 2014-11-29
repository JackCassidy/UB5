class PeptideSource < ActiveRecord::Base

  attr_accessible :file_name, :file_size, :first_line, :parse_method, :peptide_column, :to_be_uploaded

  has_many :datalines

  validates_presence_of :file_name, :file_size, :first_line, :parse_method, :peptide_column, :to_be_uploaded


  def self.parameters_from_temp_file(file)
    { :file_name => file.original_filename, :file_size => file.size, :first_line => file.tempfile.readline.chomp!}
  end

  def self.peptide_column(parse_method)
    { 'carr' => 3, 'choudhary' => 13, 'bennett' => 5 }[parse_method]
  end

  def post_initialize(up_file=nil)
    self.file_name = up_file.original_filename if up_file.try(:original_filename)
    self.file_size = up_file.size if up_file.try(:size)
    self.first_line = up_file.tempfile.readline.chomp! if up_file.try(:tempfile)
    if self.file_name =~ /carr/
      self.parse_method = :carr
      self.peptide_column = 3
    end
    if self.file_name =~ /choudhary/
      self.parse_method = :choudhary
      self.peptide_column = 13
    end
    if self.file_name =~ /bennett/
      self.parse_method = :bennett
      self.peptide_column = 5
    end
  end

  # initialize


  # Note: this is all very manual. Need to have a better way
  # to determine what type of file it is, rather than just looking
  # at the name.
  def set_peptide_column

    if self.file_name =~ /carr/
      self.parse_method = :carr
      self.peptide_column = 3
    elsif self.file_name =~ /choudhary/
      self.parse_method = :choudhary
      self.peptide_column = 13
    elsif self.file_name =~ /bennett/
      self.parse_method = :bennett
      self.peptide_column = 5
    else
      # Parsimony file, which comes in with name "Rack" something, needs to be set
      # &&& todo -- don't just set all unknown to carr!!
      self.parse_method = :carr
      self.peptide_column = 3
    end

    # would be nice to have a test here to verify that the
    # peptide column looks right

  end


  #
  # seeds.rb file gives a list of all the data files we want
  # to be looking at
  # This method reads in all the data files.
  #
  # def self.read_list_of_files(list_file_name)
  #
  #   file_list = File.new(list_file_name)
  #
  #
  #   file_list.each_line do |line|
  #     file_name, parse_method = line.split("\t")
  #     parse_method.chomp! # get rid of trailing line feed
  #
  #     a_file = File.new(file_name, 'r')
  #
  #     read_data_file(a_file, parse_method)
  #
  #   end # each_line
  #
  # end

  def self.read_data_file(a_file, parse_method)
    peptide_source = PeptideSource.new
    peptide_source.parse_method = parse_method
    peptide_source.file_name = File.basename(a_file.path)

    peptide_source.file_size = File.size(a_file)
    peptide_source.first_line = a_file.readline.chomp
    peptide_source.to_be_uploaded = true

    peptide_source.set_peptide_column

    # choudhary has an extra line at start "All di-Gly-lysines"
    if parse_method == 'choudhary'
      peptide_source.first_line = a_file.readline.chomp
    end

    peptide_source.save

    file_order = 0

    while !a_file.eof?
      @dataline = Dataline.new
      @dataline.tsv_string = a_file.readline.chomp
      @dataline.peptide_source_id = peptide_source.id
      file_order += 1
      @dataline.file_order = file_order
      peptide_source.datalines << @dataline
      @dataline.save
    end # while

    peptide_source.save!

    return peptide_source

  end

  # read_list_of_files
end # Class PeptideSource
