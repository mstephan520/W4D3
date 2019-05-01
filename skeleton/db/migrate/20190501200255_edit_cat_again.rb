class EditCatAgain < ActiveRecord::Migration[5.2]
  def change

    change_column(:cats, :user_id, :string, null: false)

  end
end
