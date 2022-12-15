class Option < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :question

  private

end
