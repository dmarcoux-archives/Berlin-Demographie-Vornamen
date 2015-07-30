require "rake"
require "rake/testtask"

require "dotenv"
# Override existing values in ENV, then load .env and if possible, .env.<environment> files.
# Overriding existing values is necessary in tasks
Dotenv.overload(Dir.pwd << "/.env",
                Dir.pwd << "/.env.#{ENV["RACK_ENV"]}")

namespace :db do
    desc "Migrate the database"
    task :migrate, [:version] do |t, args|
        require "sequel"
        Sequel.extension :migration
        db = Sequel.connect(ENV["DATABASE_URL"])
        if args[:version]
            puts "Migrating to version #{args[:version]}"
            Sequel::Migrator.run(db, "db/migrations", target: args[:version].to_i)
        else
            puts "Migrating to latest"
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

# Executing "rake test" will run all tests
Rake::TestTask.new do |t|
  t.pattern = "spec/**/*_spec.rb"
  t.verbose = true

  # TODO clean database tables
end
