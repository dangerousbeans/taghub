require 'elasticsearch/model'

class Tag < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  # has_and_belongs_to_many :people, join_table: :relations, class_name: Person, foreign_key: :thing_id, association_foreign_key: :has_id
  # has_and_belongs_to_many :places, join_table: :relations, class_name: Place,  foreign_key: :thing_id, association_foreign_key: :has_id


  has_many :taggings

  has_many :tweets, through: :taggings, source: :taggable, source_type: Tweet
  # has_many :users, through: :taggings, source: :taggable, source_type: User


  def font_size
    proportion = [ taggings_count.to_f ].max / Tag.sum(:taggings_count).to_f * 6.0

    [ proportion, 2.0 ].max
  end
end
