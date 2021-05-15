class CreateNewsletters < ActiveRecord::Migration[6.1]
  def change
    create_table :newsletters do |t|
      t.string :email
      t.boolean :woman
      t.boolean :man
      t.boolean :child

      t.timestamps
    end
  end
end
