require 'spec_helper'

describe Protein, :type => :model do
  describe "#parse_fasta_file", :type => :model do
    it "stores data from the input file to the database" do
      expect(Protein.count).to eq(0)
      path = Rails.root.join('spec', 'fixtures', 'tiny.fasta').to_s
      fasta_file = File.new(path)
      Protein.new.parse_fasta_file(fasta_file)
      expect(Protein.count).to eq(10)
    end

    it "parses the lines correctly" do
      expect(Protein.count).to eq(0)
      path = Rails.root.join('spec', 'fixtures', 'two_line.fasta').to_s
      fasta_file = File.new(path)
      Protein.new.parse_fasta_file(fasta_file)
      expect(Protein.count).to eq(2)
      first = Protein.first
      expect(first.sp_or_tr).to eq('tr')
      expect(first.description).to eq('I am a fasta description that is all alpha numeric except for = signs')
      expect(first.accession).to eq('an_accesion_number')
      expect(first.aa_sequence).to eq('MULTILINEAMINOACIDSEQUENCE')
      last = Protein.last
      expect(last.sp_or_tr).to eq('sp')
      expect(last.description).to eq('ENDOV_HUMAN Endonuclease V OS=Homo sapiens GN=ENDOV PE=2 SV=1')
      expect(last.accession).to eq('Q8N8Q3')
      expect(last.aa_sequence).to eq('MALEAAGGPPEETLSLWKREQARLKAHVVDRDTEAWQRDPAFSGLQRVGGVDVSFVKGDSVRACASLVVLSFPELEVVYEESRMVSLTAPYVSGFLAFREVPFLLELVQQLREKEPGLMPQVLLVDGNGVLHHRGFGVACHLGVLTDLPCVGVAKKLLQVDGLENNALHKEKIRLLQTRGDSFPLLGDSGTVLGMALRSHDRSTRPLYISVGHRMSLEAAVRLTCCCCRFRIPEPVRQADICSREHIRKSLGLPGPPTPRSPKAQRPVACPKGDSGESSALC')
    end
  end
end
