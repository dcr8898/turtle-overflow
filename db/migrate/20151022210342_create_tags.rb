class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :text, null: false, index: true

      t.timestamps null: false, index: true
    end
  end
end
