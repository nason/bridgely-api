class AddMessageSidToV1Message < ActiveRecord::Migration
  def self.up
    change_table(:v1_messages) do |t|
      t.string :message_sid
    end
    add_index :v1_messages, :message_sid
  end
  def self.down
    remove_column :v1_messages, :message_sid
    remove_index :v1_messages, :message_sid
  end
end
