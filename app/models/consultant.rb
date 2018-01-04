class Consultant < User
  has_many :consultations, foreign_key: "consultant_id", dependent: :destroy
end
