require 'spec_helper'
include ActionDispatch::TestProcess

describe PeptideSource do
  describe 'validations' do
    it { is_expected.to allow_mass_assignment_of(:file_name) }
    it { is_expected.to allow_mass_assignment_of(:file_size) }
    it { is_expected.to allow_mass_assignment_of(:first_line) }
    it { is_expected.to allow_mass_assignment_of(:parse_method) }
    it { is_expected.to allow_mass_assignment_of(:peptide_column) }

    it { is_expected.to have_many(:datalines) }

    it { is_expected.to validate_presence_of(:file_name) }
    it { is_expected.to validate_presence_of(:file_size) }
    it { is_expected.to validate_presence_of(:first_line) }
    it { is_expected.to validate_presence_of(:parse_method) }
    it { is_expected.to validate_presence_of(:peptide_column) }

    it { is_expected.to validate_uniqueness_of(:file_name) }
  end

  describe '.parameters_from_temp_file' do
    let(:file) { ActionDispatch::Http::UploadedFile.new(:tempfile => fixture_file_upload('/fake_peptide.txt', 'text/xml'),
                                                        :filename => 'fake_peptide.txt') }
    it 'returns parameters for peptide_source calculated from the temp file' do
      expect(PeptideSource.parameters_from_temp_file(file)).to eq({ :file_name => 'fake_peptide.txt',
                                                                    :file_size => 25,
                                                                    :first_line => 'Header1 H2 H3' })
    end
  end

  describe '.data_starts_at_line' do
    cases = { 'carr' => 2, 'choudhary' => 3, 'bennett' => 2 }
    cases.keys.each do |type|
      it "returns the right starting line for data for a #{type} file" do
        expect(PeptideSource.data_starts_at_line(type)).to eq(cases[type])
      end
    end
  end

  describe '.peptide_column' do
    cases = { 'carr' => 3, 'choudhary' => 13, 'bennett' => 5 }
    cases.keys.each do |type|
      it "returns the right peptide column for a #{type}" do
        expect(PeptideSource.peptide_column(type)).to eq(cases[type])
      end
    end
  end

  describe '#make_datalines' do
    let(:carr_second_line) { 'AAEDDEDNDVDTK(1)K_1	93	FALSE	AAEDDEDnDVDTkK	2300	2	844.37267	208.82	http://proteomics.broadinstitute.org/millscripts/viewfeed.pl?side=xl&fixedMods=iaaC+SILAC3RKmix&cycle=2&file=msdataSM/UdeshiMCP2012/cpick_in/K20110719_NU_Jurkat_rep1_KGG_SILAC_L-no_M-5uMPR619_H-5uMMG132_SCXFxn01.2300.2300.2.pkl&seq=AAEDDEDnDVDTkK	246	246	IPI00384653	0	Prothymosin a14	Prothymosin a14	Q9UMZ1	Expt1Rep1	TRUE	FALSE	FALSE	FALSE	FALSE	TRUE	FALSE	FALSE	FALSE	FALSE	-4.00	nd	-0.27	nd	nd	nd	nd	nd' }
    let(:bennett_second_line) { '1	IPI:IPI00644712.4	31	razor	1000	EASGDYKYSGRDS	ATP-dependent DNA helicase 2 subunit 1	XRCC6	10	2	9	0	0	0	0	0	9	1	2	0	3	0	17	2	2	0	0	0	3	IPI:IPI00644712.4_K31, IPI:IPI00889791.1_K31, IPI:IPI00893179.1_K31' }
    let(:choudhary_third_line) { '950	IPI00465238	Esophageal cancer-associated protein;UPF0505 protein C16orf62;cDNA FLJ37759 fis, clone BRHIP2023888;Putative uncharacterized protein C16orf62;Esophageal cancer-associated protein;UPF0505 protein C16orf62	101F10.2;C16orf62;C16orf62;101F10.2;C16orf62	Q7Z3J2-1;Q7Z3J2;B3KT69;C9J7I2;Q7Z3J2-2	GO:0005623~cell,GO:0016020~membrane,GO:0016021~integral to membrane,GO:0031224~intrinsic to membrane,GO:0044425~membrane part,GO:0044464~cell part,				0.999997	DTRTMVKTLEYIK	106.49	_TM(ox)VK(gl)TLEYIK_	TMVK(1)TLK(1)EYIK	3	452.57949	1.1994' }
    let(:carr_last_line) { 'ASAK(1)SLDR_1	5	TRUE	ASAkSLDR	2903	2	502.26199	91.853	http://proteomics.broadinstitute.org/millscripts/viewfeed.pl?side=xl&fixedMods=iaaC+SILAC3RKmix+Acetyl&cycle=1&file=msdataSM/UdeshiMCP2012/cpick_in/K20110530_NU_Jurkat_rep2_KGG_SILAC_L-5uMMG132_M-no_H-5uMPR619_SCXFxn01.2903.2903.2.pkl&seq=ASAkSLDR	247	247	IPI00301434	0	0	BolA-like protein 2	0	Expt1Rep2	FALSE	TRUE	FALSE	FALSE	FALSE	FALSE	FALSE	FALSE	FALSE	FALSE	nd	nd	nd	nd	nd	nd	nd	nd' }
    let(:bennett_last_line) { '380	IPI:IPI00031691.1	2	razor	1000	xxxxxMKTILSNQ	60S	ribosomal	protein	L9	RPL9	4	2	00	0	0	1	1	9	3	0	0	31	9	12	4	0	0	00	6	IPI:IPI00031691.1_K2,	IPI:IPI00795310.1_K2,	IPI:IPI00795717.1_K2,	IPI:IPI00909133.1_K2,	IPI:IPI00910195.1_K2,	IPI:IPI00878105.1_K2' }
    let(:choudhary_last_line) { "80	IPI00295497	3-alkyladenine DNA glycosylase;3-methyladenine DNA glycosidase;ADPG;DNA-3-methyladenine glycosylase;N-methylpurine-DNA glycosylase;N-methylpurine-DNA glycosylase, isoform CRA_c;3-alkyladenine DNA glycosylase;3-methyladenine DNA glycosidase;ADPG;DNA-3-methyladenine glycosylase;N-methylpurine-DNA glycosylase;N-methylpurine-DNA glycosylase;Proliferation-inducing protein 11;Proliferation-inducing protein 16;N-methylpurine-DNA glycosylase	AAG;ANPG;MID1;MPG;hCG_22412;AAG;ANPG;MID1;MPG;MPG;PIG16;Z69720.1-002;MPG;Z69720.1-004	P29372-1;P29372;Q1W6H1;P29372-2;Q5J9I4;A2IDA3	GO:0005622~intracellular,GO:0005623~cell,GO:0005634~nucleus,GO:0005654~nucleoplasm,GO:0031974~membrane-enclosed lumen,GO:0031981~nuclear lumen,GO:0043226~organelle,GO:0043227~membrane-bounded organelle,GO:0043229~intracellular organelle,GO:0043231~intracellular membrane-bounded organelle,GO:0043233~organelle lumen,GO:0044422~organelle part,GO:0044424~intracellular part,GO:0044428~nuclear part,GO:0044446~intracellular organelle part,GO:0044464~cell part,GO:0070013~intracellular organelle lumen,	GO:0006139~nucleobase, nucleoside, nucleotide and nucleic acid metabolic process,GO:0006163~purine nucleotide metabolic process,GO:0006195~purine nucleotide catabolic process,GO:0006259~DNA metabolic process,GO:0006281~DNA repair,GO:0006284~base-excision repair,GO:0006285~base-excision repair, AP site formation,GO:0006304~DNA modification,GO:0006307~DNA dealkylation,GO:0006308~DNA catabolic process,GO:0006753~nucleoside phosphate metabolic process,GO:0006807~nitrogen compound metabolic process,GO:0006950~response to stress,GO:0006974~response to DNA damage stimulus,GO:0008152~metabolic process,GO:0009056~catabolic process,GO:0009057~macromolecule catabolic process,GO:0009117~nucleotide metabolic process,GO:0009151~purine deoxyribonucleotide metabolic process,GO:0009155~purine deoxyribonucleotide catabolic process,GO:0009166~nucleotide catabolic process,GO:0009262~deoxyribonucleotide metabolic process,GO:0009264~deoxyribonucleotide catabolic process,GO:0009394~2'-deoxyribonucleotide metabolic process,GO:0009987~cellular process,GO:0033554~cellular response to stress,GO:0034641~cellular nitrogen compound metabolic process,GO:0034655~nucleobase, nucleoside, nucleotide and nucleic acid catabolic process,GO:0034656~nucleobase, nucleoside and nucleotide catabolic process,GO:0043170~macromolecule metabolic process,GO:0043412~biopolymer modification,GO:0044237~cellular metabolic process,GO:0044238~primary metabolic process,GO:0044248~cellular catabolic process,GO:0044260~cellular macromolecule metabolic process,GO:0044265~cellular macromolecule catabolic process,GO:0044270~nitrogen compound catabolic process,GO:0045007~depurination,GO:0046483~heterocycle metabolic process,GO:0046700~heterocycle catabolic process,GO:0050896~response to stimulus,GO:0051716~cellular response to stimulus,GO:0055086~nucleobase, nucleoside and nucleotide metabolic process,	GO:0003676~nucleic acid binding,GO:0003677~DNA binding,GO:0003684~damaged DNA binding,GO:0003824~catalytic activity,GO:0003905~alkylbase DNA N-glycosylase activity,GO:0005488~binding,GO:0005515~protein binding,GO:0016787~hydrolase activity,GO:0016798~hydrolase activity, acting on glycosyl bonds,GO:0016799~hydrolase activity, hydrolyzing N-glycosyl compounds,GO:0019104~DNA N-glycosylase activity,GO:0042802~identical protein binding,	PF02245:Methylpurine-DNA glycosylase,PF02245:Pur_DNA_glyco,	1	IYFSSPKGHLTRL	128.64	_SIYFSSPK(gl)GHLTR_	SIYFSSPK(1)GHLTR	4	402.46386	0.94396 " }


    let(:format_hash) { { :carr => { :file_name => 'tiny_carr.tsv', :first_line_loaded => carr_second_line, :last_line_loaded => carr_last_line,
                                     :number_of_datalines_to_load => 9, :number_of_peptides_to_load => 8 },
                          :bennett => { :file_name => 'tiny_bennett.tsv', :first_line_loaded => bennett_second_line, :last_line_loaded => bennett_last_line,
                                        :number_of_datalines_to_load => 52, :number_of_peptides_to_load => 51 },
                          :choudhary => { :file_name => 'tiny_choudhary.tsv', :first_line_loaded => choudhary_third_line, :last_line_loaded => choudhary_last_line,
                                          :number_of_datalines_to_load => 48, :number_of_peptides_to_load => 39 },
    } }

    before do
      create(:tiny_carr)
      create(:tiny_bennett)
      create(:tiny_choudhary)
      @peptide_source_path = UB5::Application.config.peptide_source_path
      UB5::Application.config.peptide_source_path = Rails.root.join('spec', 'fixtures')
    end

    after do
      UB5::Application.config.peptide_source_path = @peptide_source_path
    end

   # [:carr, :bennett, :choudhary].each do |format|
    [:choudhary].each do |format|
      context "for a #{format} file" do
        it "adds all the right rows to the datalines table" do

          expect(Dataline.count).to eq(0)

          PeptideSource.read_data_file(format_hash[format][:file_name])

          expect(Dataline.count).to eq(format_hash[format][:number_of_datalines_to_load])  #todo -- stop loading dataline if no peptide present -- see both  Dataline.parse_peptides and Peptide.one_raw_peptide
          expect(Peptide.count).to eq(format_hash[format][:number_of_peptides_to_load])
        end
      end
    end
  end


  describe 'other methods' do
    pending
  end
end