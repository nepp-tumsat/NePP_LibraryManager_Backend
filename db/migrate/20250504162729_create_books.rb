class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.text :description
      t.string :cover_image_url
      t.integer :page_count
      t.integer :price
      t.boolean :availability
      t.float :rating
      t.string :reviews_count
      t.date :published_date
      t.timestamps
    end
  end
end
