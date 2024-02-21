class CreateAnnotators < ActiveRecord::Migration[7.1]
  def change
    create_table :annotators do |t|
      t.string :fullname
      t.string :email, null: false, default: ""
      t.references :editor, null: false, foreign_key: true

      t.timestamps
    end

    add_index :annotators, :email, unique: true
  end
end
