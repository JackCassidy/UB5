FactoryGirl.define do
  factory(:peptide_source) do
    file_name 'FactoryFileName'
    file_size 1234
    first_line 'Factory first line columnname1 columname2'
    parse_method 'Factory_parse'
    peptide_column 13
    to_be_uploaded true
  end
end