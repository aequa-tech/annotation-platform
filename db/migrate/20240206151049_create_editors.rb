# frozen_string_literal: true

class CreateEditors < ActiveRecord::Migration[7.1]
  def change
    create_table :editors do |t|
      t.string :fullname
      t.string :email, null: false, default: ""

      t.timestamps
    end

    add_index :editors, :email, unique: true
  end
end
