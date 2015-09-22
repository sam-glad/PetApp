class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :body, null: false
      t.integer :application_form_id, null: false

      t.timestamps null: false
    end
  end
end
