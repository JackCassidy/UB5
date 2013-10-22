class CreatePeptides < ActiveRecord::Migration
  def change
    create_table :peptides do |t|
      t.string :aseq

      t.timestamps
    end
  end
end
