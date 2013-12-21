
# Little test - try out some things

# first set up the rails environment

ENV['RAILS_ENV'] = "development" # Set to your desired Rails environment name
#require '/Users/jack4janice/rails_projects/UB5/config/environment.rb'
require_relative '../config/environment.rb'



puts "Read tiny files"

# Read fasta file to create protein records
#
puts "Reading fasta file"
in_fast = File.new('./tiny.fasta')
Protein.parse_fasta_file(in_fast)


#
# Read data file and create peptides and datalines
#
puts "Reading experiment files"
Infile.read_list_of_files('./tiny_data_list.txt')

#
# For each peptide, find the associated proteins
#
puts "Matching peptides to proteins"
Peptide.all.each do |pep|
  pep.find_my_proteins
end

unaffiliated = Peptide.unaffiliated_peptides

puts unaffiliated.to_s


#
