class AddPositionToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :position, :integer, null: 0
  end
end
