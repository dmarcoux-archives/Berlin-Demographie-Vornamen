# The data is in CSV files, being one file per neighbohood
require "csv"

# The CSV files are in db/seeds/
Dir.chdir("db/seeds/")

data_files = Dir.glob("*.csv").map { |filename| CSV.open(filename, mode = "r") } 

data_files.each { |data_file|
    # The name of the neighborhood is the name of the file. Berlin Open Data seems to use this standard
    neighborhood = data_file.path

    # Process all the names listed in the file and skips the header
    names = data_file.readlines()[1..-1]
    puts names.length
}
