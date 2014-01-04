
# Try some stuff in debugger

# first set up the rails environment

ENV['RAILS_ENV'] = "test" # Set to your desired Rails environment name
                          #require '/Users/jack4janice/rails_projects/UB5/config/environment.rb'
require_relative '../../config/environment.rb'

pp Dir.pwd

upl = Rack::Test::UploadedFile.new('../fixtures/tiny_carr.tsv', 'text/xml')

inf = Infile.new()
pp inf.inspect

inf.post_initialize(upl)

pp inf.inspect
