class Peptide < ActiveRecord::Base
  attr_accessible :aseq, :mod_loc

  has_many :datalines

  validates :aseq, length: { in: 3..255 }

end
