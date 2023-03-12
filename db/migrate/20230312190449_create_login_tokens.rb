class CreateLoginTokens < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'pgcrypto'
    create_table :login_tokens, id: :uuid do |t|
      t.string :email, null: false
      t.integer :ttl, null: false, default: 600
      t.timestamps
    end
  end
end
