require 'spec_helper'

describe PeptideProtein, :type => :model do
  it { is_expected.to allow_mass_assignment_of :peptide_id }
  it { is_expected.to allow_mass_assignment_of :protein_id }
  it { is_expected.to allow_mass_assignment_of :protein_mod_site }

  it { is_expected.to belong_to(:protein) }
  it { is_expected.to belong_to(:peptide) }

  it { is_expected.to validate_presence_of :peptide_id }
  it { is_expected.to validate_presence_of :protein_id }
  it { is_expected.to validate_presence_of :protein_mod_site }
end
