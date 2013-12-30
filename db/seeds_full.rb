# Read in data that is needed to start the databasee
#

# Read fasta file to create protein records
#
puts "Reading fasta file"
in_fast = File.new('../Data/uniprot-uniprot-human-refproteome-reviewed+unreviewed2_splice_isoforms+GFP.fasta')
Protein.parse_fasta_file(in_fast)

puts Time.now.asctime


#
# Read data file and create peptides and datalines
#
puts "Reading experiment files"
Infile.read_list_of_files('./script/big_data_list.txt')

puts Time.now.asctime

#
# Parse peptide strings out of datalines
#
puts "Parsing peptides"
Infile.all.each do |inf|
  @parse_method = inf.parse_method
  @pep_col = Dataline.look_up_peptide_column(@parse_method)
  inf.datalines.all.each do |dat|
    dat.parse_peptides(@parse_method, @pep_col)
  end
end

#
# For each peptide, find the associated proteins
#
puts "Matching peptides to proteins"
Peptide.all.each do |pep|
  pep.find_my_proteins
end

puts Time.now.asctime







