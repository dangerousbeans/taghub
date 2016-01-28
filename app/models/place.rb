class Place < ActiveRecord::Base
  acts_as_taggable
  include MakerThing

  def self.data_fields
    [
      { name: :website,    type: :string },
      { name: :facebook,   type: :string },
      { name: :twitter,    type: :string },
      { name: :address,    type: :text }
    ]
  end
end
