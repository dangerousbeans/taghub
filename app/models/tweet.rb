class Tweet < ActiveRecord::Base
  acts_as_taggable

  def safe_data
    OpenStruct.new(data)
  end
end
