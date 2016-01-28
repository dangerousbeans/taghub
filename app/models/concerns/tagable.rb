#
# Stuff that is taggable should include this
#

module Tagable
  extend ActiveSupport::Concern

    included do
      acts_as_taggable

    end

    def tag_names
      tags.collect(&:name)
    end

  # Called by the elasticsearch indexer and should add the tag names
  def as_indexed_json(options={})
    as_json(include: { tags: { only: :name } } )
  end
end
