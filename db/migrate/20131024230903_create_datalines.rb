class CreateDatalines < ActiveRecord::Migration
  def change
    create_table :datalines do |t|
      t.references :peptide
      t.text :tsv_string

      t.timestamps
    end
    add_index :datalines, :peptide_id
  end
end
