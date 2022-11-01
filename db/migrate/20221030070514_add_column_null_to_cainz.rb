class AddColumnNullToCainz < ActiveRecord::Migration[6.1]
  def change
    change_column_null :cainzs, :name, false
    change_column_null :cainzs, :url, false
    change_column_null :cainzs, :image, false
  end
end
