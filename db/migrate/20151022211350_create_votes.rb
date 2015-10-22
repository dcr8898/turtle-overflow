class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :value, null: false
      t.references :user, null: false, index: true
      t.references :voteable, polymorphic: true, index: true, null: false

      t.timestamps null: false, index: true
    end
  end
end
