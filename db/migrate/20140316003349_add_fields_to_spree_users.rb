class AddFieldsToSpreeUsers < ActiveRecord::Migration
  def change
    add_column :spree_users, :first_name, :string
    add_column :spree_users, :last_name, :string
    add_column :spree_users, :icon_content_type, :string
    add_column :spree_users, :icon_file_size, :integer
    add_column :spree_users, :icon_updated_at, :datetime    
  end
end
