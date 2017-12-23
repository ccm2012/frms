class AddGoogleColumnsToCustomer < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :provider, :string
    add_column :customers, :access_token, :string
    add_column :customers, :uid, :string
    add_column :customers, :google_secret, :string
  end
end
