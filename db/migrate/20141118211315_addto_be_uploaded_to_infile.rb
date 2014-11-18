class AddtoBeUploadedToInfile < ActiveRecord::Migration
  def change
    add_column :infiles, :to_be_uploaded, :boolean
  end
end
