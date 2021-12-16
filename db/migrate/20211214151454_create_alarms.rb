class CreateAlarms < ActiveRecord::Migration[6.1]
  def change
    create_table :alarms do |t|
      t.string :title
      t.string :time
      t.integer :user_alarm_id

      t.timestamps
    end
  end
end
