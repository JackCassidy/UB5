# Read in data that is needed to start the databasee
#

# Read fasta file to create protein records
#
puts "Reading fasta file"
in_fast = File.new('../Data/uniprot-uniprot-human-refproteome-reviewed+unreviewed2_splice_isoforms+GFP.fasta')
Protein.parse_fasta_file(in_fast)


#
# Read data file and create peptides and datalines
#
puts "Reading experiment files"
Infile.read_list_of_files('/Users/jack4janice/rails_projects/Data/seeds_input_list.txt')

#
# For each peptide, find the associated proteins
#
puts "Matching peptides to proteins"
Peptide.all.each do |pep|
  pep.find_my_proteins
end







