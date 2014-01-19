require "rubygems"
require "active_record"

ActiveRecord::Base.establish_connection(
  :adapter  => "sqlite3",
  :database => "dam.sqlite3",
  :timeout  => 5000
)

begin
  ActiveRecord::Migration.create_table :records do |t|
    t.column :dam_id, :integer
    t.column :time       , :datetime
    t.column :precipitation   , :float
    t.column :precipitation_type , :string
    t.column :stored , :float
    t.column :stored_type, :string
    t.column :income, :float
    t.column :income_type, :string
    t.column :outbound, :float
    t.column :outbound_type, :string
    t.column :stored_percentage, :float
    t.column :stored_percentage_type, :string
    t.column :created_at, :datetime
    t.column :updated_at, :datetime
  end
rescue
end