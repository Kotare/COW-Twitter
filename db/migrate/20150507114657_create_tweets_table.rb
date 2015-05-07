class CreateTweetsTable < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :content, null: false
      t.reference :user, index: true, null: false
      t.timestamps null: false
    end
  end
end
