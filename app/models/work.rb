# == Schema Information
# Schema version: 20111220151843
#
# Table name: works
#
#  id          :integer(4)      not null, primary key
#  day         :date
#  description :string(255)
#  time        :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer(4)      not null
#  task_id     :integer(4)      not null
#

class Work < ActiveRecord::Base
  belongs_to :user
  
  validates :day, :presence => true
  validates :time, :presence =>true
  validates :description,  :presence => true,
                            :length   => { :maximum => 255 }
  validates :user_id, :presence => true 
  
  validates_format_of :day, :with => /\d{4}\-\d{2}\-\d{2}/, :message => "Date must be in the following format: yyyy-mm-dd"
  validates_numericality_of :time, :integer_only => true, :greater_than => 0  
end
