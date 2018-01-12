class Event < ActiveRecord::Base
  belongs_to :user
  has_many :consultations, dependent: :destroy #updateしないのでupdate時には評価しない
  validates_presence_of :planed_start, on: :create #updateしないのでupdate時には評価しない
  validates :title, length: { in: 1..100 }, on: :create #updateしないのでupdate時には評価しない
  validate :isconflict, on: :create #updateしないのでupdate時には評価しない
  validate :ispast, on: :create #updateしないのでupdate時には評価しない

  scope :conflict, -> (planed_start, planed_end) do
    where("(events.planed_start >= now())AND((events.planed_start <= ? AND events.planed_end >= ? ) OR (events.planed_start <= ? AND events.planed_end >= ?))", planed_start, planed_start, planed_end, planed_end)
  end

  def isconflict
    if planed_start.present? && Event.conflict(planed_start, planed_end).present?
      errors.add(:planed_start,"が他の相談と重なっています。別の時間にしてください。")
    end
  end

  def ispast
    if planed_start.present? && planed_start <= Time.now
      errors.add(:planed_start,"が過ぎています。後の時間にしてください。")
    end
  end

  def self.between(start_time, end_time)
    where('planed_start > ? AND planed_start <?',start_time, end_time)
  end

  def as_json(options = {})
    {
      :start => planed_start,
      :end => planed_end
    }
  end
end
