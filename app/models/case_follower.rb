class CaseFollower < ActiveRecord::Base

    belongs_to :case
    belongs_to :user

    def click?
      self.increment!(:repeat_click, by=1)
    end

end
