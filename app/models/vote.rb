class Vote < ActiveRecord::Base
  belongs_to :voteable, :polymorphic => true

  validates_uniqueness_of :voteable_id, :scope => [:voteable_type, :ip]
end
