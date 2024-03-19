class CreateAnnotations < ActiveRecord::Migration[7.1]
  def change
    create_table :annotations do |t|
      t.references :text_line, null: false, foreign_key: true
      t.references :annotator, null: false, foreign_key: true
      t.jsonb :content

      t.timestamps
    end
  end
end
