class CreateTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :todos do |t|
      t.references :user
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
