class AddIndexToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.integer   :login_count,         :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
      t.integer   :failed_login_count,  :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
      t.datetime  :last_request_at                                    # optional, see Authlogic::Session::MagicColumns
      t.datetime  :current_login_at                                   # optional, see Authlogic::Session::MagicColumns
      t.datetime  :last_login_at                                      # optional, see Authlogic::Session::MagicColumns
      t.string    :current_login_ip                                   # optional, see Authlogic::Session::MagicColumns
      t.string    :last_login_ip
    end
    add_index(:users, [:username, :email], :unique => true)
  end

  def self.down
    change_table :users do |t|
      t.remove  :login_count
      t.remove  :failed_login_count
      t.remove  :last_request_at
      t.remove  :current_login_at
      t.remove  :last_login_at
      t.remove  :current_login_ip
      t.remove  :last_login_ip
    end
    remove_index(:users, [:username, :email])
  end
end