class AddIndexToOrganizationMemberships < ActiveRecord::Migration
  def change
    add_index :organization_memberships, [ :user_id, :organization_id ], unique: true, name: 'by_user_and_organization'
  end
end
