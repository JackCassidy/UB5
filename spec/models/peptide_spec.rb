require 'spec_helper'
require 'shoulda-matchers'
require 'shoulda/matchers/integrations/rspec'

describe Peptide do

  it { should have_many(:datalines) }

  it { should allow_mass_assignment_of(:aseq) }
  it { should allow_mass_assignment_of(:mod_loc) }

  it { should validate_presence_of :aseq }
  it { should validate_presence_of :mod_loc }




end

def perform
  str1 = 'ASAK(1)SLDR_1	5	TRUE	ASAkSLDR	2903	2	502.26199	91.853	http://proteomics.broadinstitute.org/millscripts/viewfeed.pl?side=xl&fixedMods=iaaC+SILAC3RKmix+Acetyl&cycle=1&file=msdataSM/UdeshiMCP2012/cpick_in/K20110530_NU_Jurkat_rep2_KGG_SILAC_L-5uMMG132_M-no_H-5uMPR619_SCXFxn01.2903.2903.2.pkl&seq=ASAkSLDR	247	247	IPI00301434	0	0	BolA-like protein 2	Expt1Rep2	FALSE	TRUE	FALSE	FALSE	FALSE	FALSE	FALSE	FALSE	FALSE	FALSE	nd	nd	nd	nd	nd	nd	nd	nd'

  Peptide.parse_dataline str1
end


describe '#parse_dataline' do


  expect {
    perform
  }.to change { Peptide.count }.by(1)

end

