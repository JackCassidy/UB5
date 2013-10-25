class Protein < ActiveRecord::Base
  attr_accessible :aa_sequence, :accession, :description, :sp_or_tr

  validates :sp_or_tr, :presence => true
  validates :accession, :presence => true
  validates :description, :presence => true
  validates :aa_sequence, :presence => true

end
