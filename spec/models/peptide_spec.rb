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


describe '#parse_dataline' do
  it 'should write one record for a valid input line' do

    puts "Peptide.count before #{Peptide.count}"

    count_before = Peptide.count
    str1 = 'ASAK(1)SLDR_1	5	TRUE	ASAkSLDR	2903	2	502.26199	91.853	http://proteomics.broadinstitute.org/millscripts/viewfeed.pl?side=xl&fixedMods=iaaC+SILAC3RKmix+Acetyl&cycle=1&file=msdataSM/UdeshiMCP2012/cpick_in/K20110530_NU_Jurkat_rep2_KGG_SILAC_L-5uMMG132_M-no_H-5uMPR619_SCXFxn01.2903.2903.2.pkl&seq=ASAkSLDR	247	247	IPI00301434	0	0	BolA-like protein 2	Expt1Rep2	FALSE	TRUE	FALSE	FALSE	FALSE	FALSE	FALSE	FALSE	FALSE	FALSE	nd	nd	nd	nd	nd	nd	nd	nd'
    Peptide.parse_dataline str1

    Peptide.count.should == count_before + 1
  end

  it 'should not write a record for the header line' do
    count_before = Peptide.count
    str_heading = 'Unmodified peptide	K-ε-GG Site [nd=K-ε-GG localization identifier <0.5]	Nterm_Acetylation on peptide True or False?	Modified Peptide (Sequence Input for Viewer; for peptides with >1 K-ε-GG site having a localization identifier of 0.5, the K-ε-GG site was placed on the first of the two lysine residues for the viewer; k=K-ε-GG site, m=methionine oxidation, n=asparagine deamidation)	Scan Number shown in Viewer	Charge State of Precursor Shown in Veiwer	m/z of Precursor Shown in Viewer	Andromeda Score of MS/MS Scan Shown in Viewer		"Length of URLin link"		Leading Proteins	Gene Names	Protein Names	Protein Descriptions	Uniprot	Experiment	Expt1Rep1 (K-ε-GG Peptide Identified True or False?)	Expt1Rep2 (K-ε-GG Peptide Identified True or False?)	Expt2Rep1 (K-ε-GG Peptide Identified True or False?)	Expt2Rep2 (K-ε-GG Peptide Identified True or False?)	Expt1Rep1_Unfractionated (K-ε-GG Peptide Identified True or False?)	Expt1Rep1_Fractionated (K-ε-GG Peptide Identified True or False?)	Expt2Rep1_Unfractionated (K-ε-GG Peptide Identified True or False?) 	Expt2Rep1_Fractionated (K-ε-GG Peptide Identified True or False?)	Expt2Rep2_Unfractionated (K-ε-GG Peptide Identified True or False?)	Expt2Rep2_Fractionated (K-ε-GG Peptide Identified True or False?)	Rep1 SILAC Log2 Ratio 5uM MG-132/0.5% DMSO (H/L)	Rep2 SILAC Log2 Ratio 5uM MG-132/0.5% DMSO (L/M)	Rep1 SILAC Log2 Ratio 5uM PR-619/0.5% DMSO (M/L)	Rep2 SILAC Log2 Ratio 5uM PR-619/0.5% DMSO (H/M)	Rep1 SILAC Log2 Ratio 17uM PR-619/0.5% DMSO (M/L)	Rep2 SILAC Log2 Ratio 17uM PR-619/0.5% DMSO (H/M)	Rep1 SILAC Log2 Ratio 17uM PR-619 & 5uM MG-132/0.5% DMSO (H/L)	Rep2 SILAC Log2 Ratio 17uM PR-619 & 5uM MG-132/0.5% DMSO (L/M)'
    Peptide.parse_dataline str_heading

    Peptide.count.should == count_before
  end

  it 'should not write a record if no modified lysine' do
    count_before = Peptide.count
    str_no_mod = 'AAEDDEDNDVDTKKQKTDEDD_1	nd	FALSE	AAEDDEDnDVDTKKQKTDEDD	5669	4	628.50858	70.802	http://proteomics.broadinstitute.org/millscripts/viewfeed.pl?side=xl&fixedMods=iaaC+SILAC3RKmix&cycle=1&file=msdataSM/UdeshiMCP2012/cpick_in/K20110810_NU_Jurkat_rep2B_KGG_SILAC_L-17uMPR619-5uMMG132_M-no_H-17uMPR619_SCXFxn02.5669.5669.4.pkl&seq=AAEDDEDnDVDTKKQKTDEDD	265	265	IPI00384653	0	Prothymosin a14	Prothymosin a14	Q9UMZ1	Expt2Rep2	FALSE	FALSE	FALSE	TRUE	FALSE	FALSE	FALSE	FALSE	FALSE	TRUE	nd	nd	nd	nd	nd	-0.36	nd	-0.15'
    Peptide.parse_dataline str_no_mod

    Peptide.count.should == count_before
  end

  it 'should not add twice if peptide already in db' do
    count_before = Peptide.count
    dl1 = 'ALEAAGGPPEETLSLWK(1)R_1	18	TRUE	ALEAAGGPPEETLSLWkR	13951	3	694.36025	93.823	http://proteomics.broadinstitute.org/millscripts/viewfeed.pl?side=xl&fixedMods=iaaC+SILAC3RKmix+Acetyl&cycle=1&file=msdataSM/UdeshiMCP2012/cpick_in/K20110530_NU_Jurkat_rep2_KGG_SILAC_L-5uMMG132_M-no_H-5uMPR619_SCXFxn01.13951.13951.3.pkl&seq=ALEAAGGPPEETLSLWkR	259	259	IPI00167531	0	Putative endonuclease FLJ39025	Isoform 1 of Putative endonuclease FLJ39025;Isoform 3 of Putative endonuclease FLJ39025;Isoform 2 of Putative endonuclease FLJ39025	Q8N8Q3-1;Q8N8Q3;Q8N8Q3-3;Q8N8Q3;Q8N8Q3-2;Q8N8Q3	Expt1Rep2	FALSE	TRUE	FALSE	FALSE	FALSE	FALSE	FALSE	FALSE	FALSE	FALSE	nd	4.60	nd	4.33	nd	nd	nd	nd'
    dl2 = 'ALEAAGGPPEETLSLWK(1)R_1	18	TRUE	ALEAAGGPPEETLSLWkR	13952	3	694.36025	93.823	http://proteomics.broadinstitute.org/millscripts/viewfeed.pl?side=xl&fixedMods=iaaC+SILAC3RKmix+Acetyl&cycle=1&file=msdataSM/UdeshiMCP2012/cpick_in/K20110530_NU_Jurkat_rep2_KGG_SILAC_L-5uMMG132_M-no_H-5uMPR619_SCXFxn01.13951.13951.3.pkl&seq=ALEAAGGPPEETLSLWkR	259	259	IPI00167531	0	Putative endonuclease FLJ39025	Isoform 1 of Putative endonuclease FLJ39025;Isoform 3 of Putative endonuclease FLJ39025;Isoform 2 of Putative endonuclease FLJ39025	Q8N8Q3-1;Q8N8Q3;Q8N8Q3-3;Q8N8Q3;Q8N8Q3-2;Q8N8Q3	Expt1Rep2	FALSE	TRUE	FALSE	FALSE	FALSE	FALSE	FALSE	FALSE	FALSE	FALSE	nd	4.60	nd	4.33	nd	nd	nd	nd'
    Peptide.parse_dataline dl1
    Peptide.parse_dataline dl2

    Peptide.count.should == count_before + 1
  end

  it 'should not add a peptide if the string has non-alphabetic characters' do
    count_before = Peptide.count
    bad_pep =  'ALEAAGGPPEETLSLWK(1)R_1	18	TRUE	ALEAAGG_PPEE*TLSLWkR	13951	3	694.36025	93.823	http://proteomics.broadinstitute.org/millscripts/viewfeed.pl?side=xl&fixedMods=iaaC+SILAC3RKmix+Acetyl&cycle=1&file=msdataSM/UdeshiMCP2012/cpick_in/K20110530_NU_Jurkat_rep2_KGG_SILAC_L-5uMMG132_M-no_H-5uMPR619_SCXFxn01.13951.13951.3.pkl&seq=ALEAAGGPPEETLSLWkR	259	259	IPI00167531	0	Putative endonuclease FLJ39025	Isoform 1 of Putative endonuclease FLJ39025;Isoform 3 of Putative endonuclease FLJ39025;Isoform 2 of Putative endonuclease FLJ39025	Q8N8Q3-1;Q8N8Q3;Q8N8Q3-3;Q8N8Q3;Q8N8Q3-2;Q8N8Q3	Expt1Rep2	FALSE	TRUE	FALSE	FALSE	FALSE	FALSE	FALSE	FALSE	FALSE	FALSE	nd	4.60	nd	4.33	nd	nd	nd	nd'
    Peptide.parse_dataline bad_pep

    Peptide.count.should == count_before
  end

end

