# The data is in CSV files, being one file per neighbohood
require 'csv'
require 'sequel'

# Initialize the database
Sequel.connect(ENV['DATABASE_URL'])

# Then we can load the Name model
require_relative '../../models/name'

# The CSV files are in db/seeds/
Dir.chdir('db/seeds/')

# Open the CSV files
data_files = Dir.glob('*.csv').map { |filename| CSV.open(filename, 'r') }

data_files.each do |data_file|
  # The name of the neighborhood is the name of the file
  # Berlin Open Data seems to use this standard
  neighborhood = data_file.path.gsub('.csv', '')

  # Retrieve all the names listed in the file and skips the header
  names = data_file.readlines[1..-1]

  # Insert the names in the database
  names.each do |name|
    fields = name[0].split(';')

    # The model doesn't have to be validated, the data will be validated by the database anyway
    Name.new(name: fields[0], count: fields[1], gender: fields[2], neighborhood: neighborhood)
      .save(validate: false)
  end

  # Providing some feedback to the user
  puts "#{neighborhood.capitalize}: #{names.length} names inserted"
end
