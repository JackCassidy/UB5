class DatalinesRenameInfileIdToPeptideSourceId < ActiveRecord::Migration
  def change
    rename_column :datalines, :infile_id, :peptide_source_id
  end
end
