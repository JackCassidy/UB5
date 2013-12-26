class AddProteinToDataline < ActiveRecord::Migration
  def change
    add_column :datalines, :protein_id, :integer
  end
end
