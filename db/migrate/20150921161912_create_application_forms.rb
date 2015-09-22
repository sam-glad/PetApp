class CreateApplicationForms < ActiveRecord::Migration
  def change
    create_table :application_forms do |t|
      t.string :name, null: false
      t.integer :organization_id # Leaving null possible so that users can select
                                 # from a list of premade, seeded forms later

      t.timestamps null: false
    end
  end
end
