class ImportMember < ActiveRecord::Base
  belongs_to :user
  belongs_to :member, :class_name => "User", :foreign_key => "member_id"

end
