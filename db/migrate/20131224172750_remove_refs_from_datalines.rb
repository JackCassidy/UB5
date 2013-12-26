class RemoveRefsFromDatalines < ActiveRecord::Migration
  def up
    remove_column :datalines, :peptide_id
    remove_column :datalines, :protein_id
  end

  def down
    add_column :datalines, :protein_id, :integer
    add_column :datalines, :peptide_id, :integer
  end
end
