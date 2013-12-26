class AddModLocToDatalines < ActiveRecord::Migration
  def change
    add_column :datalines, :protein_modification_location, :integer
  end
end
