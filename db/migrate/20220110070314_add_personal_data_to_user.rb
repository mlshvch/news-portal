class AddPersonalDataToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :surname, :string
    add_column :users, :nickname, :string
    add_column :users, :birthday, :date
  end
end
