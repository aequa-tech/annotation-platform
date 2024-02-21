class CreateTextLines < ActiveRecord::Migration[7.1]
  def change
    create_table :text_lines do |t|
      t.string :external_id
      t.text :content, null: false
      t.integer :position, null: false
      t.references :corpus, null: false, foreign_key: true

      t.timestamps
    end
  end
end
