
# Little test - try out some things

# first set up the rails environment

ENV['RAILS_ENV'] = "development" # Set to your desired Rails environment name
#require '/Users/jack4janice/rails_projects/UB5/config/environment.rb'
require_relative '../config/environment.rb'



puts "Test funny dataline"

dline = "16957	IPI:IPI00328298.6	1227	razor	1000	PKEIASKGLCxxx	Isoform 2 of Structural maintenance of chromosomes protein 4	SMC4	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0IPI:IPI00328298.6_K1227, IPI:IPI00411559.2_K1285
17026	IPI:IPI00024684.1	712	razor	1000	LCQFSSKEIHxxx	Interferon-induced GTP-binding protein Mx2	MX2	0IPI:IPI00024684.1_K712, IPI:IPI00790233.1_K186"

# unaffiliated = Peptide.unaffiliated_peptides



#
