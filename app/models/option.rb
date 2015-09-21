class Option < ActiveRecord::Base
  validates :body, presence: true
  validates :question_id, presence: true

  belongs_to :question
end
