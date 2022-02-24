namespace :test do
  namespace :system do
    task :with, [:driver] => :environment do |task, args|
      ENV["DRIVER"] = args[:driver]
      Rake::Task["test:system"].invoke
    end
  end
end
