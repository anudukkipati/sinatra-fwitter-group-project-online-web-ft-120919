class Tweet < ActiveRecord::Base
  belongs_to :user

  def created_at_stamp
    self.created_at.strftime("%A, %d %b %Y %l:%M %p")
  end
end
