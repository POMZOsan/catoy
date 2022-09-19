class CreateCats < ActiveRecord::Migration[6.1]
  def change
    create_table :cats do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null:false
      t.integer :sex, default: 0
      t.integer :character, default: 0
      t.datetime :birth_date

      t.timestamps
    end
  end
end
