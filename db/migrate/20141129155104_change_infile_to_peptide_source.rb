class ChangeInfileToPeptideSource < ActiveRecord::Migration
  def change
    rename_table :infiles, :peptide_sources
  end
end
