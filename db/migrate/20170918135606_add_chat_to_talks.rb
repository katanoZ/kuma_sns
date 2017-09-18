class AddChatToTalks < ActiveRecord::Migration[5.1]
  def change
    add_reference :talks, :chat, foreign_key: true, index: true
    add_reference :talks, :user, foreign_key: true, index: true
    add_column :talks, :read, :boolean, default: false
  end
end
