class Question < ActiveRecord::Base
  validates :body, presence: true, uniqueness: true, allow_blank: false
  validates :application_form, presence: true

  belongs_to :application_form, inverse_of: :questions
  has_many :answers, inverse_of: :question
  accepts_nested_attributes_for :answers, allow_destroy: true
end
