class CreateCars < ActiveRecord::Migration

  ##############################################################################
  def change
    create_table(:cars) do |t|
      # Create a foreign key to link to the users table.  This could
      # have been: t.belongs_to(:user)
      t.column(:user_id, :integer)
      t.column(:name,    :string)
      t.timestamps
    end

    # Add a database index for user_id since we'll most often be
    # pulling cars using that column.
    add_index(:cars, :user_id)
  end
end
