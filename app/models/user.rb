class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  enum role: [:teacher, :student]

  has_many :tests
  has_many :questions
  has_many :options

  after_initialize do
    if self.new_record?
      self.role ||= :student
    end
  end

  def is_teacher?
    self.role == "teacher"
  end

  def is_student?
    self.role == "student"
  end

  def on_jwt_dispatch(payload)
    JwtDenylist.create!(
      jti: payload['jti'],
      exp: Time.zone.at(payload['exp']),
      user_id: id
    )
  end

  private

end
