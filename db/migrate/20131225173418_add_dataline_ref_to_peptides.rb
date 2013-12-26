class AddDatalineRefToPeptides < ActiveRecord::Migration
  def change
    add_column :peptides, :dataline_id, :integer
    add_index :peptides, :dataline_id
  end
end
