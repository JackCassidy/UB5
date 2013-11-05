
# Little test - try out some things

# first set up the rails environment

ENV['RAILS_ENV'] = "development" # Set to your desired Rails environment name
require '/Users/jack4janice/rails_projects/UB5/config/environment.rb'

pep1 = Peptide.find(1)
pep1.find_my_proteins

pep2 = Peptide.find(2)
pep2.find_my_proteins


