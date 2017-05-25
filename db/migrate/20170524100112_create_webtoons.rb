class CreateWebtoons < ActiveRecord::Migration
  def change
    create_table :webtoons do |t|
      t.text :day
      t.timestamps null: false
    end
  end
end
