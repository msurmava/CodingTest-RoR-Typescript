class Todo < ApplicationRecord
  validates :title, uniqueness: true, presence: true
  enum priority: [:low, :normal, :high]
  after_initialize :set_default_priority, :if => :new_record?
 
  def set_default_priority
    self.priority ||= :normal
  end
end
