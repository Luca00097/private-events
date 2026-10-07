class AddIsPrivateToEvents < ActiveRecord::Migration[8.1]
  def change
    add_column :events, :is_private, :boolean, default: true, null: false
  end
end
