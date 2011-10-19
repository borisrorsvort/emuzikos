class CreateInstruments < ActiveRecord::Migration
  def self.up
    create_table :instruments do |t|
      t.string :name

      t.timestamps
    end
    change_table :users do |t|
      t.remove :guitar
      t.remove :bass
      t.remove :double_bass
      t.remove :drums
      t.remove :violin
      t.remove :flute
      t.remove :piano
      t.remove :percussions
      t.remove :voice
      t.remove :turntables
      t.remove :banjo
      t.remove :cithar
      t.remove :bouzouki
      t.remove :mandolin
      t.remove :whistles
      t.remove :spoons
      t.remove :keyboard
      t.remove :ocarina
      t.remove :congas
      t.remove :is_admin
    end
  end

  def self.down
    drop_table :instruments
    change_table :users do |t|
      t.boolean :guitar
      t.boolean :bass
      t.boolean :double_bass
      t.boolean :drums
      t.boolean :violin
      t.boolean :flute
      t.boolean :piano
      t.boolean :percussions
      t.boolean :voice
      t.boolean :turntables
      t.boolean :banjo
      t.boolean :cithar
      t.boolean :bouzouki
      t.boolean :mandolin
      t.boolean :whistles
      t.boolean :spoons
      t.boolean :keyboard
      t.boolean :ocarina
      t.boolean :congas
      t.boolean :is_admin, :default => false
    end
  end
end
