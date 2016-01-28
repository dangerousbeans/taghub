class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :voteable, polymorphic: true
      t.string  :ip
      t.datetime :created_at
    end
    # add_index :votes, :voteable_id, :voteable_type, :ip
  end
end
