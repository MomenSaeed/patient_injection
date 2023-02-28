class CreateInjections < ActiveRecord::Migration[7.0]
  def change
    create_table :injections, id: :uuid do |t|
      t.float :dose
      t.string :lot_number
      t.string :drug_name
      t.references :patient, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
