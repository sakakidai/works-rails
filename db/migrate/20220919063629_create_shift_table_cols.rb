class CreateShiftTableCols < ActiveRecord::Migration[7.0]
  def change
    create_table :shift_table_cols do |t|
      t.references :shift_table, foreign_key: true
      t.date :work_on

      t.timestamps
    end
  end
end
