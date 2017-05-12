class ChangePhysiqueColumnInUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :physique
    add_column :users, :stamina, :integer
    add_column :users, :strength, :integer
    add_column :users, :agility, :integer
  end
end
