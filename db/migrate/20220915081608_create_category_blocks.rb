class CreateCategoryBlocks < ActiveRecord::Migration[6.1]
  def change
    create_table :category_blocks do |t|
      t.references :category, null: false, foreign_key: true
      t.references :blockable, null: false, polymorphic: true

      t.timestamps
    end
  end
end
