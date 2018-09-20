# USAGE (from root): ruby utils/csv_to_rooms.rb ./title.csv
require 'csv'
require 'active_support/core_ext/hash'
require 'yaml'

CSV_FILE = ARGV[0]
KEY = CSV_FILE.split('.csv').first.gsub('./', '')

rooms = YAML.safe_load(File.read('./rooms.yml'))
csv = CSV.read(CSV_FILE).to_h.deep_stringify_keys

rooms.deep_stringify_keys!
rooms.each do |id, props|
  rooms[id][KEY] = csv[id] if csv[id]
end

rooms.transform_keys! { |k| k.to_i == 0 ? k : k.to_i }

File.write("./new_rooms_#{KEY}.yml", rooms.to_yaml)
