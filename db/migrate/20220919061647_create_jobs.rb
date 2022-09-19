class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.string :prefecture_code
      t.string :city_code
      t.string :name
      t.text :occupation
      t.text :payment
      t.text :location
      t.text :working_hours

      t.timestamps
    end
  end
end
