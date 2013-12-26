class CreateProteins < ActiveRecord::Migration
  def change
    create_table :proteins do |t|
      t.string :sp_or_tr
      t.string :accession
      t.string :description
      t.text :aa_sequence

      t.timestamps
    end
  end
end
