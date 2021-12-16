class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :cntr
      t.integer :user_alarm_id

      t.timestamps
    end
  end
end
