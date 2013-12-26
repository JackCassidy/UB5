class CreatePeptideProteins < ActiveRecord::Migration
  def change
    create_table :peptide_proteins do |t|
      t.integer :peptide_id
      t.integer :protein_id
      t.integer :protein_mod_site

      t.timestamps
    end
    add_index :peptide_proteins, :peptide_id
    add_index :peptide_proteins, :protein_id
  end
end
