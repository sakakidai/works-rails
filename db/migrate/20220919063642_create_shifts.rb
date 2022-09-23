class CreateShifts < ActiveRecord::Migration[7.0]
  def change
    create_table :shifts do |t|
      t.references :shift_table_col, foreign_key: true
      t.integer :recruiting_number, null: false, default: 0
      t.integer :applicant_number, null: false, default: 0
      t.boolean :recruited, null: false, default: 0
      t.datetime :work_start_at
      t.datetime :work_end_at

      t.timestamps
    end
  end
end
