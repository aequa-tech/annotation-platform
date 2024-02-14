class AddDeviseToEditors < ActiveRecord::Migration[7.1]
  def change
    add_column :editors, :encrypted_password, :string, null: false, default: ""
    ## Recoverable
    add_column :editors, :reset_password_token, :string
    add_column :editors, :reset_password_sent_at, :datetime
    ## Rememberable
    add_column :editors, :remember_created_at, :datetime
  end
end
