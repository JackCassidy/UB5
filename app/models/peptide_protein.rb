class PeptideProtein < ActiveRecord::Base
  attr_accessible :peptide_id, :protein_id, :protein_mod_site

  belongs_to :protein
  belongs_to :peptide

  validates :peptide_id, :presence => true
  validates :protein_id, :presence => true
  validates :protein_mod_site, :presence => true

end
