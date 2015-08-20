require "rake"
require "rake/testtask"

unless ENV["RACK_ENV"] == "production"
    require "dotenv"
    # Override existing values in ENV, then load .env and if possible, .env.<environment> files.
    # Overriding existing values is necessary in tasks
    Dotenv.overload(Dir.pwd << "/.env",
                    Dir.pwd << "/.env.#{ENV["RACK_ENV"]}")
end

# Prevent errors...
# Idea from http://technotes.iangreenleaf.com/posts/confirmation-for-destructive-rake-tasks.html
task :confirm_env do
  puts "Verify your RACK_ENV! Are you sure you want to continue? [y/N]"
  input = STDIN.gets.chomp
  raise NO unless input.downcase == "y"
end

namespace :db do
    desc "Clean the database by dropping all tables"
    task clean: :confirm_env do
        require "sequel"
        db = Sequel.connect(ENV["DATABASE_URL"])
        puts "Cleaning the database"
        db.drop_table(:names, :schema_info)
    end

    desc "Migrate the database"
    task :migrate, [:version] do |t, args|
        require "sequel"
        Sequel.extension :migration
        db = Sequel.connect(ENV["DATABASE_URL"])
        if args[:version]
            puts "Migrating the database to the version #{args[:version]}"
            Sequel::Migrator.run(db, "db/migrations", target: args[:version].to_i)
        else
            puts "Migrating the database to the latest version"
            Sequel::Migrator.run(db, "db/migrations")
        end
    end

    desc "Seed the database"
    task :seed do
        seed_file = File.join('db/seeds/seeds.rb')
        if File.exist?(seed_file)
            puts "Seeding the database"
            load(seed_file)
        end
    end
end

# Executing "rake test" will reset the database, then execute the tests
Rake::TestTask.new(test: ["db:clean", "db:migrate"]) do |t|
    t.pattern = "spec/**/*_spec.rb"
end
