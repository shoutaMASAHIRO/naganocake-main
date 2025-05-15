# frozen_string_literal: true

class DeviseCreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at
      
      t.string :last_name,                       null: false, default: ""
      t.string :first_name,                      null: false, default: ""
      t.string :last_name_kana,                  null: false, default: ""
      t.string :first_name_kana,                 null: false, default: ""
      t.string :email,                           null: false, default: ""
      t.string :encrypted_password,              null: false, default: ""
      t.string :postal_code,                     null: false, default: ""
      t.string :address,                         null: false, default: ""
      t.string :phone_number,                null: false, default: ""

      t.timestamps null: false
    end

    add_index :customers, :email,                unique: true
    add_index :customers, :reset_password_token, unique: true
    # add_index :customers, :confirmation_token,   unique: true
    # add_index :customers, :unlock_token,         unique: true
  end
end
