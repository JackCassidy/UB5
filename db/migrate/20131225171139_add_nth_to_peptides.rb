class AddNthToPeptides < ActiveRecord::Migration
  def change
    add_column :peptides, :nth, :integer
    add_column :peptides, :searched, :boolean
  end
end
