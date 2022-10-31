class AddColumnNullToRakutens < ActiveRecord::Migration[6.1]
  def change
    change_column_null :rakutens, :name, false
    change_column_null :rakutens, :url, false
    change_column_null :rakutens, :image, false
  end
end
