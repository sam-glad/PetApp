class CreateBreeds < ActiveRecord::Migration
  def change
    create_table :breeds do |t|
      t.string :name, null: false
      t.integer :pet_id, null: false
    end
  end
end
