class CreateShiftTables < ActiveRecord::Migration[7.0]
  def change
    create_table :shift_tables do |t|
      t.references :job, foreign_key: true
      t.date :work_start_on
      t.date :work_end_on

      t.timestamps
    end
  end
end
