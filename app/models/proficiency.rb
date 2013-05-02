class Proficiency < ActiveRecord::Base
  belongs_to :user
  belongs_to :skill
  validates_inclusion_of :formal, :in => [true, false]
end
