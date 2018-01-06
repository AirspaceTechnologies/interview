class CreateAddresses < ActiveRecord::Migration
  def change
  	create_table :addresses do |t|
  		t.string :full_address
  		t.float :lat
  		t.float :lng
  	end
  end
end
