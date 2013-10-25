class Dataline < ActiveRecord::Base
  belongs_to :peptide
  attr_accessible :tsv_string
end
