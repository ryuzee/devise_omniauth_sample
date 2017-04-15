class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :display_name, :string, null: false, default: ''
    add_column :users, :biography, :string, null: false, default: ''
  end
end
