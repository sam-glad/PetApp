class AddPositionToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :position, :integer, default: 1
  end
end
