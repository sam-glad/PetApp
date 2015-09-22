class Answer < ActiveRecord::Base
  validates :body, presence: true
  validates :question, presence: true

  belongs_to :question, inverse_of: :answers
end
