# Read in data that is needed to start the databasee
#

# Read fasta file to create protein records
#
in_fast = File.new('../TinyData/tiny.fasta')
Protein.parse_fasta_file(in_fast)


#
# Read data file and create peptides and datalines
#
Infile.read_list_of_files('/Users/jack4janice/rails_projects/TinyData/seeds_input_list.txt')

#
# For each peptide, find the associated proteins
#
Peptide.all.each do |pep|
  pep.find_my_proteins
end







