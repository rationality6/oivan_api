class Question < ApplicationRecord
  belongs_to :user
  belongs_to :test

  has_many :options

  private

end
