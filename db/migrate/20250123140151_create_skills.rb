class CreateSkills < ActiveRecord::Migration[8.0]
  def change
    create_table :skills do |t|
      t.string :name
      t.timestamps

      t.references :user, null: false, foreign_key: true

      t.index [ :name, :user_id ], unique: true
    end
  end
end
