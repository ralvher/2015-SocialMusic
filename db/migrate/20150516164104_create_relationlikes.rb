class CreateRelationlikes < ActiveRecord::Migration
  def change
    create_table :relationlikes do |t|
      t.integer :post_id
      t.integer :liker_id

      t.timestamps null: false
    end
  end
end
