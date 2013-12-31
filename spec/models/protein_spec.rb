require 'spec_helper'

describe Protein do
  pending "add some *** model validation *** and maybe some further test of the methode in #{__FILE__}"
end

describe "#parse_fasta_file" do
  it "stores data from the input file to the database" do
    expect(Protein.count).to eq(0)
    path = Rails.root.join('spec', 'fixtures', 'tiny.fasta').to_s
    fasta_file = File.new(path)
    Protein.parse_fasta_file(fasta_file)
    expect(Protein.count).to eq(10)
  end
end
