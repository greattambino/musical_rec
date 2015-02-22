class AlterColumnVideosDislikes < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :videos do |t|
        dir.up   { t.change :dislikes, :string }
        dir.down { t.change :dislikes, :integer }
      end
    end
  end
end
