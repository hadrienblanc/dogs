class AddErrorMessageToDogRequest < ActiveRecord::Migration[7.1]
  def change
    add_column :dog_requests, :error_message, :text
  end
end
