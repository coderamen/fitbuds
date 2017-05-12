class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :country, :string
    add_column :users, :age_range, :integer
    add_column :users, :physique, :integer
    add_column :users, :additional_health_problems, :string
    add_column :users, :weekly_activity_hours, :integer
  end
end
