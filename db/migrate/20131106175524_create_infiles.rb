class CreateInfiles < ActiveRecord::Migration
  def change
    create_table :infiles do |t|
      t.string :file_name
      t.string :parse_method
      t.integer :file_size
      t.text :first_line

      t.timestamps
    end
  end
end
