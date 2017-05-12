class CreateTables < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.string :name
    end

    create_table :pendings do |t|
      t.integer :activity_id
      t.integer :user_id
      t.string :city
      t.datetime :datetime
      t.integer :status

      t.timestamps
    end

    create_table :match_statuses do |t|
      t.integer :pending_viewer_id
      t.integer :pending_viewed_id
      t.integer :status
    end

    create_table :matches do |t|
      t.integer :user1_id
      t.integer :user2_id
      t.integer :user1_pending_id
      t.integer :user2_pending_id

      t.timestamps
    end

    create_table :confirmed_activities do |t|
      t.integer :match_id
      t.integer :activity_id
      t.string :location
      t.datetime :datetime
      t.integer :duration_in_hours
      t.boolean :user1_confirm
      t.boolean :user2_confirm

      t.timestamps
    end
  end
end
