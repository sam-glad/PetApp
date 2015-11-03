class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :body, null: false
      t.integer :application_form_id
      t.integer :pet_application_id
      t.boolean :is_required, default: false, null: false
      t.integer :input_type

      t.timestamps null: false
    end
  end
end
