class Consultation < ActiveRecord::Base
  belongs_to :consultant, class_name: "User"
  belongs_to :client, class_name: "User"
  belongs_to :event
end
