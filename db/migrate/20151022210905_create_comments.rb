class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.references :user, null: false, index: true
      t.references :commentable, polymorphic: true, index: true, null: false

      t.timestamps null: false, index: true
    end
  end
end
