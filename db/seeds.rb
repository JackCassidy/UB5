# Read in data that is needed to start the databasee
#


# Read fasta file to create protein records
#

in_fast = File.new('../TinyData/tiny.fasta')
Protein.parse_fasta_file(in_fast)
#
# Read data file and create peptides, datalines
#

in_tiny = File.new('../TinyData/tiny.tsv')
puts 'Reading tiny.tsv'

line = in_tiny.readline.chomp     # discard first line

while !in_tiny.eof?
  line = in_tiny.readline.chomp
  Peptide.parse_dataline(line)
end







