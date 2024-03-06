class AddLinesSetIdToTextLines < ActiveRecord::Migration[7.1]
  def change
    add_reference :text_lines, :lines_set, foreign_key: true
  end
end
