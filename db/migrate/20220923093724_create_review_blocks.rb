class CreateReviewBlocks < ActiveRecord::Migration[6.1]
  def change
    create_table :review_blocks do |t|
      t.references :review, null: false, foreign_key: true
      t.references :product, null: false, polymorphic: true

      t.timestamps
    end
  end
end
