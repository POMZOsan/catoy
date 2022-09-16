class RemoveNullFlase < ActiveRecord::Migration[6.1]
  def change
    change_column_null :categories, :name, true
  end
end
