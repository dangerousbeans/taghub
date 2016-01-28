require 'elasticsearch/rails/tasks/import'


task :refresh_es => :environment do
  [ Tweet, Story ].each do |entity|
    entity.__elasticsearch__.create_index! force: true
    entity.__elasticsearch__.refresh_index!
    entity.import
  end
end
