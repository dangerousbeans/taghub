class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :tweet_id
      t.jsonb :data

      t.timestamps null: false
    end
  end
end
