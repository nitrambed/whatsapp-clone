class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :user_contact, null: false, foreign_key: true

      t.timestamps
    end
  end
end
