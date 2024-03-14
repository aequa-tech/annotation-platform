class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.references :annotator, null: false, foreign_key: true
      t.references :lines_set, null: false, foreign_key: true

      t.timestamps
    end
    add_index :tasks, [:annotator_id, :lines_set_id], unique: true

    add_reference :annotations, :task, foreign_key: true
  end
end
