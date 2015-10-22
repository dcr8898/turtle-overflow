class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.references :user, null: false, index: true
      t.references :answer, index: true

      t.timestamps null: false, index: true
    end
  end
end
