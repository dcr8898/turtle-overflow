class CreateQuestionsTags < ActiveRecord::Migration
  def change
    create_table :question_tags do |t|
      t.references :question, null: false, index: true
      t.references :tag, null: false, index: true

      t.timestamps null: false, index: true
    end
  end
end
