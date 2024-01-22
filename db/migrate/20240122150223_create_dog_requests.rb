class CreateDogRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :dog_requests do |t|
      t.string :breed
      t.string :url
      t.datetime :responded_at

      t.timestamps
    end
  end
end
