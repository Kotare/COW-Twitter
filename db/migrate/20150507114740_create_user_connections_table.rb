class CreateUserConnectionsTable < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.integer :follower_id, index: true, null: false
      t.integer :followee_id, index: true, null: false
    end
  end
end
