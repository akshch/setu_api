class AddColumnChannelToCenters < ActiveRecord::Migration[6.1]
  def change
    add_column :centers, :channel, :string
  end
end
