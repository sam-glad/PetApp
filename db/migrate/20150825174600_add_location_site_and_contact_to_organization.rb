class AddLocationSiteAndContactToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :city, :string, null: false
    add_column :organizations, :state_province, :string, null: false
    add_column :organizations, :country, :string, null: false
    add_column :organizations, :phone_number, :string
    add_column :organizations, :phone_extension, :string
    add_column :organizations, :email_address, :string
    add_column :organizations, :website, :string
    add_column :organizations, :phone_preferred, :bool
  end
end
