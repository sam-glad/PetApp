class CreatePetApplications < ActiveRecord::Migration
  def change
    create_table :pet_applications do |t|
      t.integer :user_id
      t.integer :pet_id
      t.integer :organization_id
      t.integer :application_type
      t.integer :status, default: 0 # TODO: Replace with hash

      t.timestamps null: false
    end
  end
end
