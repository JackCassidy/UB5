class AddPeptideColumnToInfile < ActiveRecord::Migration
  def change
    add_column :infiles, :peptide_column, :integer
  end
end
