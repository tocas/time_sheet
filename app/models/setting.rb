# == Schema Information
# Schema version: 20111220151843
#
# Table name: settings
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  APIkey     :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer(4)      not null
#  enabled    :boolean(1)
#

class Setting < ActiveRecord::Base
  belongs_to :user
end
