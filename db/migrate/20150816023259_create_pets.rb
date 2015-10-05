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
      t.string :status
      t.boolean :good_with_dogs
      t.boolean :good_with_cats
      t.boolean :good_with_kids
      t.integer :organization_id
      t.integer :application_form_id

      t.timestamps null: false
    end
  end
end
