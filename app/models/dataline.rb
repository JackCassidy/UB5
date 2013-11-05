class Dataline < ActiveRecord::Base
  belongs_to :peptide
  belongs_to :protein
  attr_accessible :tsv_string, :protein_modification_location
end
