class CreateUsers < ActiveRecord::Migration
  
  ##############################################################################
  # With Rails 3.1 you only need one method in your migration:
  # `change`.  It's an instance method and if you are reverting a
  # migration its actions are reversed automatically.
  #
  # If you need more control you can define two instance methods: `up`
  # and `down`.
  def change
    create_table(:users) do |t|
      t.column(:first_name,      :string)
      t.column(:last_name,       :string)
      t.column(:email,           :string)
      t.column(:password_digest, :string)
      
      # The following shortcut creates two columns in the database:
      # `created_at` and `updated_at` which Rails automatically
      # updates as necessary.
      t.timestamps
    end
  end
  
  ##############################################################################
  # Some people prefer this alternate version of create_table (which
  # does the same thing):
  #
  #  create_table(:users) do |t|
  #    t.string(:first_name)
  #    t.string(:last_name)
  #    t.string(:email)
  #    t.string(:password_digest)
  #    t.timestamps
  #  end
end
