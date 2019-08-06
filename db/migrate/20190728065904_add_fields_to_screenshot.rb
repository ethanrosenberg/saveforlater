class AddFieldsToScreenshot < ActiveRecord::Migration[5.2]
  def change
    add_column :screenshots, :file_name, :text
    add_column :screenshots, :client_modified, :text
  end
end
