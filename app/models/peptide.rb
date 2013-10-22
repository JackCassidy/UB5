class Peptide < ActiveRecord::Base
  attr_accessible :aseq, :mod_loc

  validates :aseq, length: { in: 3..255 }

end
