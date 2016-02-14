FactoryGirl.define do
  factory :organization_membership do
    is_admin true
    after(:build) do |organization_membership|
      organization_membership.user = FactoryGirl.create(:user)
      organization_membership.organization = FactoryGirl.create(:organization)
    end
  end
end
