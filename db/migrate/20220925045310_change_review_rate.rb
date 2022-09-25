class ChangeReviewRate < ActiveRecord::Migration[6.1]
  def up
    change_table :reviews do |t|
      t.change :rate, :integer
    end
  end

  def down
    change_table :reviews do |t|
      t.change :rate, :float
    end
  end
end
