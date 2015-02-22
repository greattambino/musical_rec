class AlterColumnVideosViews < ActiveRecord::Migration
  def self.up
    change_table :videos do |t|
      t.change :views, :string
    end
  end
  def self.down
    change_table :videos do |t|
      t.change :views, :integer
    end
  end
end
