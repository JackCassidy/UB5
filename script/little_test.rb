
# Little test - try out some things

# first set up the rails environment

ENV['RAILS_ENV'] = "development" # Set to your desired Rails environment name
#require '/Users/jack4janice/rails_projects/UB5/config/environment.rb'
require_relative '../config/environment.rb'


Infile.read_list_of_files('/Users/jack4janice/rails_projects/TinyData/seeds_input_list.txt')


