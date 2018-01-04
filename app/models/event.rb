class Event < ActiveRecord::Base
    belongs_to :user
    has_many :consultations, dependent: :destroy
    validates_presence_of :planed_start
    validates :title, length: { in: 1..100 }
end
