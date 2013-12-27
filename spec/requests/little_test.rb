
# Little test - try out some things

# first set up the rails environment

ENV['RAILS_ENV'] = "test" # Set to your desired Rails environment name
#require '/Users/jack4janice/rails_projects/UB5/config/environment.rb'
require_relative '../../config/environment.rb'


puts "Read tiny files"

# Read fasta file to create protein records
#
puts "Reading fasta file"
in_fast = File.new('../fixtures/tiny.fasta')
Protein.parse_fasta_file(in_fast)


#
# Read data file and create peptides and datalines
#
puts "Reading experiment files"
Infile.read_list_of_files('../fixtures/tiny_data_list.txt')

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

puts "finding unaffiliated"
unaffiliated = Peptide.unaffiliated_peptides

unaffiliated.each do |ua|
  puts ua.to_s
end



#
