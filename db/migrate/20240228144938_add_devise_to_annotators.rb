class AddDeviseToAnnotators < ActiveRecord::Migration[7.1]
  def change
    add_column :annotators, :encrypted_password, :string, null: false, default: ""
    ## Recoverable
    add_column :annotators, :reset_password_token, :string
    add_column :annotators, :reset_password_sent_at, :datetime
    ## Rememberable
    add_column :annotators, :remember_created_at, :datetime
  end
end
