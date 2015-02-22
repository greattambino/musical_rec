class AlterColumnVideosLikes < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :videos do |t|
        dir.up   { t.change :likes, :string }
        dir.down { t.change :likes, :integer }
      end
    end
  end
end
