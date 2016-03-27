require 'rake'
require 'rake/testtask'

namespace :db do
  desc 'Clean the database by dropping all tables'
  task :clean do
    require 'sequel'
    db = Sequel.connect(ENV['DATABASE_URL'])
    puts 'Cleaning the database'
    db.drop_table(:names, :schema_info)
  end

  desc 'Migrate the database'
  task :migrate, [:version] do |_t, args|
    require 'sequel'
    Sequel.extension :migration
    db = Sequel.connect(ENV['DATABASE_URL'])
    if args[:version]
      puts "Migrating the database to the version #{args[:version]}"
      Sequel::Migrator.run(db, 'db/migrations', target: args[:version].to_i)
    else
      puts 'Migrating the database to the latest version'
      Sequel::Migrator.run(db, 'db/migrations')
    end
  end

  desc 'Seed the database'
  task :seed do
    seed_file = File.join('db/seeds/seeds.rb')
    if File.exist?(seed_file)
      puts 'Seeding the database'
      load(seed_file)
    end
  end
end

# Executing 'rake test' will reset the database, then execute the tests
Rake::TestTask.new(test: ['db:clean', 'db:migrate']) do |t|
  t.pattern = 'spec/**/*_spec.rb'
end
