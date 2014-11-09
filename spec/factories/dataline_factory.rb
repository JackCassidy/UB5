FactoryGirl.define do
  factory(:dataline) do
    tsv_string "column 0\tDDD"
    # factory(:carr_dataline) do
    #   tsv_string "column 0\tcolumn 1 !@#$%^&*(){}\tcolumn 2\tAAAAAAAA\t4"
    # end
    # factory(:benett_dataline) do
    #   tsv_string "column 0\tcolumn 1 !@#$%^&*(){}\tcolumn 2\tcol 3\t4\tSSSSSS\t6"
    # end
    # factory(:choudhary_dataline) do
    #   tsv_string "column 0\tcolumn 1 !@#$%^&*(){}\tcolumn 2\tcol 3\t4\t5\t6\t7\t8\t9\t10\t11\t12\tLLLLLLLLLLLLL"
    # end
  end
end
