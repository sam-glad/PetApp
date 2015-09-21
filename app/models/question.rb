class Question < ActiveRecord::Base
  validates :body, presence: true, uniqueness: true, allow_blank: false
  validates :application_form_id, presence: true

  belongs_to :application_form
end
