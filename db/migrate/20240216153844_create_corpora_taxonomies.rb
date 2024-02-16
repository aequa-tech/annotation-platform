class CreateCorporaTaxonomies < ActiveRecord::Migration[7.1]
  def change
    create_table :corpora_taxonomies do |t|
      t.references :corpus, null: false, foreign_key: true
      t.references :taxonomy, null: false, foreign_key: true

      t.timestamps
    end

    add_index :corpora_taxonomies, [:corpus_id, :taxonomy_id], unique: true
  end
end
