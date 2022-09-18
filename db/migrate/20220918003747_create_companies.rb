class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|

      t.string :name
      t.string :name_kana
      t.string :zip_code
      t.string :address_city
      t.string :address_street
      t.string :address_building
      t.string :president
      t.integer :phone_number
      t.timestamps
    end
  end
end
