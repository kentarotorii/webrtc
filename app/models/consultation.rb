class Consultation < ActiveRecord::Base

  mount_uploader :data, DataUploader
  belongs_to :consultant, class_name: "User"
  belongs_to :client, class_name: "User"
  belongs_to :event
  has_many  :comments, dependent: :destroy
  has_many  :reports, dependent: :destroy
  mount_uploader :data, DataUploader

  validates :memo, length: { in: 1..400 }

  def image_data(recordeddata)
   # decode data and create stream on them
   io = CarrierStringIO.new(Base64.decode64(recordeddata))
   # this will do the thing (photo is mounted carrierwave uploader)
   self.data = io
 end

end
