class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.string :commenter
      t.string :body
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end