class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :animal
      t.boolean :is_mix?
      t.string :age
      t.string :name
      t.string :size
      t.string :sex
      t.string :description
      t.boolean :good_with_dogs
      t.boolean :good_with_cats
      t.boolean :good_with_kids

      # Non-Petfinder columns
      t.boolean :is_fosterable, null: false, default: false
      t.boolean :is_adoptable, null: false, default: false
      t.integer :status
      t.integer :organization_id
      t.integer :adoption_application_id
      t.integer :foster_application_id

      t.timestamps null: false
    end
  end
end
