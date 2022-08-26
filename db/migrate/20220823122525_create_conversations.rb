class CreateConversations < ActiveRecord::Migration[6.1]
  def change
    create_table :conversations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :user_contact, null: false, foreign_key: true

      t.timestamps
    end
  end
end
