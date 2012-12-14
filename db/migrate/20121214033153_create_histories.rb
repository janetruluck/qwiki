class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.integer :page_id
      t.integer :user_id
      t.string :note
      t.text :current_content
      t.text :previous_content

      t.timestamps
    end
  end
end
