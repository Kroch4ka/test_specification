class CreateInterests < ActiveRecord::Migration[8.0]
  def change
    create_table :interests do |t|
      t.string :name
      t.timestamps

      t.references :user, null: false, foreign_key: true
    end
  end
end
