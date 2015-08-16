class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :animal
      t.boolean :mix
      t.integer :age
      t.string :name
      t.datetime :available_date
      t.string :size
      t.string :sex
      t.integer :weight
      t.string :description
      t.string :status
      t.boolean :good_with_dogs
      t.boolean :good_with_cats
      t.boolean :good_with_kids
      t.boolean :fence_required
      t.integer :fence_height
      t.boolean :breed_experience_required
      t.integer :organization_id

      t.timestamps null: false
    end
  end
end
