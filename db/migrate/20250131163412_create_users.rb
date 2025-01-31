class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.string :password_digest
      t.integer :status, default: 0  # active = 0

      t.timestamps
    end
  end
end
