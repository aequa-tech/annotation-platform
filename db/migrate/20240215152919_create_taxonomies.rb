class CreateTaxonomies < ActiveRecord::Migration[7.1]
  def change
    create_table :taxonomies do |t|
      t.string :title
      t.string :description
      t.references :editor, null: false, foreign_key: true

      t.timestamps
    end

    add_index :taxonomies, %i[title editor_id], unique: true
  end
end
