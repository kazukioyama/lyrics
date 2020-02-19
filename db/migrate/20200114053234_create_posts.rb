class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :image
      t.string :artist
      t.string :title
      t.text :lyric
      t.text :body
      t.string:youtube_url

      t.timestamps
    end
  end
end
