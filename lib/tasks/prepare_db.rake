
namespace :build do

  desc 'Build database'
  task db: :environment do
    Rake::Task['environment'].invoke
    database_exist = begin
      ActiveRecord::Base.connection.present?
    rescue ActiveRecord::NoDatabaseError
      false
    end

    if database_exist
    
      puts 'Database exists, process finished successfully'
    
    else
    
      puts 'Database does not exist, process started...'
    
      Rake::Task['db:setup'].invoke
    
      puts 'Database created.'
    end
  end
end