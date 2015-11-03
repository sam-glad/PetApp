class Question < ActiveRecord::Base
  validates :body, presence: true, allow_blank: false

  # enum input_type: [ :textbox_small, :textbox_large, :dropdown, :radio, :checkbox ]

  belongs_to :application_form
  belongs_to :pet_application
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, allow_destroy: true
end
