class AddFileOrderToDatalines < ActiveRecord::Migration
  def change
    add_column :datalines, :file_order, :integer
  end
end
