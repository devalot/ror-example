class CreateRefuels < ActiveRecord::Migration

  ##############################################################################
  def change
    create_table(:refuels) do |t|
      t.column(:car_id,      :integer)
      t.column(:refueled_at, :datetime)
      t.column(:odometer,    :integer)
      t.column(:gallons,     :float)
      t.column(:mpg,         :float)
      t.column(:distance,    :integer)
      t.column(:price_cents, :integer, :default => 0)
      t.timestamps
    end
    
    add_index(:refuels, :car_id)
    add_index(:refuels, [:car_id, :refueled_at], :unique => true)
  end
end
