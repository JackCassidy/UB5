class AddModLockToPeptides < ActiveRecord::Migration
  def change
    add_column :peptides, :mod_loc, :integer
  end
end
