class PeptideSource < ActiveRecord::Base

  attr_accessible :file_name, :file_size, :first_line, :parse_method, :peptide_column, :to_be_uploaded

  has_many :datalines

  validates_presence_of :file_name, :file_size, :first_line, :parse_method, :peptide_column, :to_be_uploaded
  validates_uniqueness_of :file_name


  def self.parameters_from_temp_file(file)
    { :file_name => file.original_filename, :file_size => file.size, :first_line => file.tempfile.readline.chomp! }
  end

  def self.peptide_column(parse_method)
    { 'carr' => 3, 'choudhary' => 13, 'bennett' => 5 }[parse_method]
  end

  def self.data_starts_at_line(parse_method)
    { 'carr' => 2, 'choudhary' => 3, 'bennett' => 2 }[parse_method]
  end


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



  def self.read_data_file(file_name)  #todo refactor to use as PeptideSource.new(file_name)
    peptide_source = PeptideSource.where(:file_name => file_name).first
    full_file_path = File.join(UB5::Application.config.peptide_source_path, file_name)
    counter = 0
    parse_method = peptide_source.parse_method
    peptide_column = peptide_source.peptide_column
    data_start_line = self.data_starts_at_line(parse_method)
    peptide_source_id = peptide_source.id

    File.open(full_file_path, 'r') do |file|
      file.each_line do |line|
        counter += 1
        if counter >= data_start_line && line.present?
          dataline = Dataline.create!(peptide_source_id: peptide_source_id,
                           file_order: counter,
                           tsv_string: line)  # if we used chomp, it would remove the entire last line of the bennett file!?
          dataline.parse_peptides(parse_method, peptide_column)
        end
      end
    end
  end

end # Class PeptideSource
