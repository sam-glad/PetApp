class ConsolidatePermissions < ActiveRecord::Migration
  def change
    add_column :organization_memberships, :is_admin, :bool, default: false
    remove_column :organization_memberships, :can_manage_pet_applications, :bool, default: false
    remove_column :organization_memberships, :can_edit_all_pets, :bool, default: false
    remove_column :organization_memberships, :can_manage_application_forms, :bool, default: false
  end
end
