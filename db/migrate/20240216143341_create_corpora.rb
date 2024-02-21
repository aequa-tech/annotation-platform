class CreateCorpora < ActiveRecord::Migration[7.1]
  def change
    create_table :corpora do |t|
      t.string :title
      t.references :editor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
