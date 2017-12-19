class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :events, dependent: :destroy
  has_many :consultations, foreign_key: "consultant_id", dependent: :destroy
  has_many :reverse_consultations, foreign_key: "client_id", class_name: "Consultation", dependent: :destroy
  #has_many :consultants, through: :relationships, source: :followed
  #has_many :clients, through: :reverse_relationships, source: :follower

end
