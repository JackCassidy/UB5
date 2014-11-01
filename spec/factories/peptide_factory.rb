FactoryGirl.define do
  factory(:peptide) do
    aseq 'IAMANAMINAACIDSEQUENCE'
    mod_loc 7
    nth 1
    dataline_id 1
  end
end