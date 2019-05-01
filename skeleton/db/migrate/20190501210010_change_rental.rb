class ChangeRental < ActiveRecord::Migration[5.2]
  def change

    add_column :cat_rental_requests, :user_id, :integer, null: false
    add_index :cat_rental_requests, :user_id, unique: true

  end
end
