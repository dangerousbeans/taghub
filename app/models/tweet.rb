class Tweet < ActiveRecord::Base
  def safe_data
    OpenStruct.new(data)
  end

end
