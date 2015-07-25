# The data is in CSV files, being one file per neighbohood
require "csv"
require "sequel"

# Initialize the database
db = Sequel.connect(ENV["DATABASE_URL"])

# Then we can load the Name model
require_relative "../../models/name"

# The CSV files are in db/seeds/
Dir.chdir("db/seeds/")

data_files = Dir.glob("*.csv").map { |filename| CSV.open(filename, mode = "r") }

data_files.each { |data_file|
    # The name of the neighborhood is the name of the file. Berlin Open Data seems to use this standard
    neighborhood = data_file.path.gsub(".csv", "")

    # Retrieve all the names listed in the file and skips the header
    names = data_file.readlines()[1..-1]

    # Insert the names in the database
    names.each do |name|
        fields = name[0].split(";")
        Name.create(name: fields[0],
                    count: fields[1],
                    gender: fields[2],
                    neighborhood: neighborhood)
    end
}
