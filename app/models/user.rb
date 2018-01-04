class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  mount_uploader :avatar, AvatarUploader

  validates :user_type, presence: true

  has_many :events, dependent: :destroy
  #has_many :consultations, foreign_key: "consultant_id", dependent: :destroy
  #has_many :consultations, foreign_key: "client_id", dependent: :destroy
  has_many :consultings, foreign_key: "consultant_id", class_name: "Consultation", dependent: :destroy
  has_many :consulteds, foreign_key: "client_id", class_name: "Consultation", dependent: :destroy
  has_many :myclients, through: :consultings, source: :client
  has_many :myconsultants, through: :consulteds, source: :consultant
  has_many :comments, dependent: :destroy
  has_many :reports, dependent: :destroy
  #has_many :consultants, through: :relationships, source: :followed
  #has_many :clients, through: :reverse_relationships, source: :follower

end
