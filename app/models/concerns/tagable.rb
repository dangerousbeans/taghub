#
# Stuff that is taggable should include this
#

module Tagable
  extend ActiveSupport::Concern

    included do
      has_many :taggings, :as => :taggable
      has_many :tags, :through => :taggings
    end

    def tag(name)
      name.strip!
      tag = Tag.find_or_create_by_name(name)
      self.taggings.find_or_create_by_tag_id(tag.id)
    end

    def tag_names
      tags.collect(&:name)
    end
    
  # Called by the elasticsearch indexer and should add the tag names
  def as_indexed_json(options={})
    as_json(include: { tags: { only: :name } } )
  end
end
