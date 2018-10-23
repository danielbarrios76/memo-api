class CreateMemos < ActiveRecord::Migration[5.1]
  def change
    create_table :memos do |t|
      t.text :title
      t.text :body
      t.boolean :complied

      t.timestamps
    end
  end
end
