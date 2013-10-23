# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

in_tiny = File.new('../TinyData/tiny.tsv')
puts 'Reading tiny.tsv'

line = in_tiny.readline.chomp     # discard first line

while !in_tiny.eof?
  line = in_tiny.readline.chomp
  sp = line.split("\t")
  if sp.length < 4
    next
  else
    raw_pep = sp[3]
  end

  @peptide = Peptide.new
  puts raw_pep
  ml = raw_pep.index('k')   # first modified Lysine
  puts ml
  if ml.nil?
    next
  else
    @peptide.mod_loc = ml
    @peptide.aseq = raw_pep.upcase
    @peptide.save
  end
end   # while
