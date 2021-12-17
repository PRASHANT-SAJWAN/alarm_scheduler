class AddJobjidToAlarms < ActiveRecord::Migration[6.1]
  def change
    add_column :alarms, :jid, :string
    remove_column :user_alarm
  end
end
