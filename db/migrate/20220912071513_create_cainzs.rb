class CreateCainzs < ActiveRecord::Migration[6.1]
  def change
    create_table :cainzs do |t|
      t.string :name
      t.string :image
      t.string :url

      t.timestamps
    end
  end
end
