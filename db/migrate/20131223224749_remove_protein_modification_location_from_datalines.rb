class RemoveProteinModificationLocationFromDatalines < ActiveRecord::Migration
  def up
    remove_column :datalines, :protein_modification_location
  end

  def down
    add_column :datalines, :protein_modification_location, :integer
  end
end
