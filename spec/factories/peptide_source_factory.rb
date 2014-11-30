FactoryGirl.define do
  factory :peptide_source do
    file_name 'FactoryFileName'
    file_size 1234
    first_line 'Factory first line columnname1 columname2'
    parse_method 'Factory_parse'
    peptide_column 13
    to_be_uploaded true
  end

  factory :tiny_carr, class: PeptideSource do
    file_name 'tiny_carr.tsv'
    file_size 6547
    parse_method 'carr'
    peptide_column 3
    first_line 'Unmodified peptide\tK-ε-GG Site [nd=K-ε-GG localization identifier <0.5]\tNterm_Acetylation on peptide True or False?\tModified Peptide (Sequence Input for Viewer; for peptides with >1 K-ε-GG site having a localization identifier of 0.5, the K-ε-GG site was placed on the first of the two lysine residues for the viewer; k=K-ε-GG site, m=methionine oxidation, n=asparagine deamidation)\tScan Number shown in Viewer\tCharge State of Precursor Shown in Veiwer\tm/z of Precursor Shown in Viewer\tAndromeda Score of MS/MS Scan Shown in Viewer\t\t\"Length of URLin link\"\t\tLeading Proteins\tGene Names\tProtein Names\tProtein Descriptions\tUniprot\tExperiment\tExpt1Rep1 (K-ε-GG Peptide Identified True or False?)\tExpt1Rep2 (K-ε-GG Peptide Identified True or False?)\tExpt2Rep1 (K-ε-GG Peptide Identified True or False?)\tExpt2Rep2 (K-ε-GG Peptide Identified True or False?)\tExpt1Rep1_Unfractionated (K-ε-GG Peptide Identified True or False?)\tExpt1Rep1_Fractionated (K-ε-GG Peptide Identified True or False?)\tExpt2Rep1_Unfractionated (K-ε-GG Peptide Identified True or False?) \tExpt2Rep1_Fractionated (K-ε-GG Peptide Identified True or False?)\tExpt2Rep2_Unfractionated (K-ε-GG Peptide Identified True or False?)\tExpt2Rep2_Fractionated (K-ε-GG Peptide Identified True or False?)\tRep1 SILAC Log2 Ratio 5uM MG-132/0.5% DMSO (H/L)\tRep2 SILAC Log2 Ratio 5uM MG-132/0.5% DMSO (L/M)\tRep1 SILAC Log2 Ratio 5uM PR-619/0.5% DMSO (M/L)\tRep2 SILAC Log2 Ratio 5uM PR-619/0.5% DMSO (H/M)\tRep1 SILAC Log2 Ratio 17uM PR-619/0.5% DMSO (M/L)\tRep2 SILAC Log2 Ratio 17uM PR-619/0.5% DMSO (H/M)\tRep1 SILAC Log2 Ratio 17uM PR-619 & 5uM MG-132/0.5% DMSO (H/L)\tRep2 SILAC Log2 Ratio 17uM PR-619 & 5uM MG-132/0.5% DMSO (L/M)'
    to_be_uploaded true
  end

  factory :tiny_bennett, class: PeptideSource do
    file_name 'tiny_bennett.tsv'
    file_size 12675
    parse_method 'bennett'
    peptide_column 5
    first_line "site_index	protein_reference	position	redundancy	maxScore	motif_peptide	annotation	symbol	4x_Btz_rep1-4 ID's	4x_Btz_rep1-4 Quant	Btz_Epox ID's	Btz_Epox Quant	Usp2cc ID's	Usp2cc Quant	Btz_timepoints ID's	Btz_timepoints Quant	Btz_CHX ID's	Btz_CHX Quant	SILAC_Chase_GG ID's	SILAC_Chase_GG Quant	MLN_timepoints ID's	MLN_timepoints Quant	Btz_MLN_1st ID's	Btz_MLN_1st Quant	Btz_MLN_2nd ID's	Btz_MLN_2nd Quant	CST_GG_PullDowns ID's	CST_GG_PullDowns Quant	redundancy	all IPIs"
    to_be_uploaded true
  end

  factory :tiny_choudhary, class: PeptideSource do
    file_name 'tiny_choudhary.tsv'
    file_size 139129
    parse_method 'choudhary'
    peptide_column 13
    first_line 'All di-Gly-lysines'
    to_be_uploaded true
  end
end