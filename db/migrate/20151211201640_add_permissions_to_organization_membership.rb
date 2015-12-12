class AddPermissionsToOrganizationMembership < ActiveRecord::Migration
  def change
    add_column :organization_memberships, :can_view_all_applications, :bool, default: true
    add_column :organization_memberships, :can_edit_all_applications, :bool, default: true
  end
end
