class CreateLinesSets < ActiveRecord::Migration[7.1]
  def change
    create_table :lines_sets do |t|
      t.references :corpus, null: false, foreign_key: true
      t.string :title

      t.timestamps
    end

    add_index :lines_sets, %i[corpus_id title], unique: true
  end
end
