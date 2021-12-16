class CreateUserAlarms < ActiveRecord::Migration[6.1]
  def change
    create_table :user_alarms do |t|
      t.integer :user_id
      t.integer :alarm_id

      t.timestamps
    end
  end
end
