class CreateRecipients < ActiveRecord::Migration[5.2]
  def change
    create_table :recipients do |t|
      t.string :email, unique: true, null: false
      t.string :notes, limit: 1024
      t.timestamps
    end
  end
end
