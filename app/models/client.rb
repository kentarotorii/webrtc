class Client < User
  has_many :consultations, foreign_key: "client_id", dependent: :destroy
end
