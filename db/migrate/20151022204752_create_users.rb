class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false, index: true
      t.string :email
      t.string :password_digest, null: false

      t.timestamps null: false, index: true
    end
  end
end
