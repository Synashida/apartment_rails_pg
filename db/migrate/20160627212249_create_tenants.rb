class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.string :subdomain

      t.timestamps null: false
    end
  end
end
