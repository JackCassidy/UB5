class AddInfileRefToDataline < ActiveRecord::Migration
  def change
    add_column :datalines, :infile_id, :integer
  end
end
