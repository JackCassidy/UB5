class Infile < ActiveRecord::Base
  attr_accessible :file_name, :file_size, :first_line, :parse_method

  has_many :datalines

end
