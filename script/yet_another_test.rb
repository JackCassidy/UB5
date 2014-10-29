
# first set up the rails environment

ENV['RAILS_ENV'] = "development" # Set to your desired Rails environment name
                                 #require '/Users/jack4janice/rails_projects/UB5/config/environment.rb'
require_relative '../config/environment.rb'

puts "Finding unaffiliated"

unaffiliated = Peptide.unaffiliated_peptides

for uf in unaffiliated
  puts uf.to_s
end
