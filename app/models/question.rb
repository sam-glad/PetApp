class Question < ActiveRecord::Base
  validates :body, presence: true, allow_blank: false
  validates :application_form, presence: true

  # enum input_type: [ :textbox_small, :textbox_large, :dropdown, :radio, :checkbox ]

  belongs_to :application_form, inverse_of: :questions
  has_many :answers, inverse_of: :question, dependent: :destroy
  accepts_nested_attributes_for :answers, allow_destroy: true
end
