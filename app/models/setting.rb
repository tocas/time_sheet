# == Schema Information
# Schema version: 20110616224220
#
# Table name: settings
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  APIkey     :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer(4)      not null
#

class Setting < ActiveRecord::Base
  belongs_to :user
end
