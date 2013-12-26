
# Little test - try out some things

# first set up the rails environment

ENV['RAILS_ENV'] = "development" # Set to your desired Rails environment name
                                 #require '/Users/jack4janice/rails_projects/UB5/config/environment.rb'
require_relative '../config/environment.rb'



puts "Finding peptides with multiple proteins"

pps = []
Peptide.find_in_batches(:batch_size => 100) do |group|
  group.each do |pp|

   if pp.proteins.count > 1
      pps << pp
    end   # if

  end

end

puts "There are #{pps.count} peptides with multiple proteins"
#
