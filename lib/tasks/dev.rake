namespace :dev do

  task :fake => :environment do
    Menu.delete_all
    10.times do |i|
      puts "fake #{i}"
      Menu.create!( :name => Faker::App.name,
                    :image => Faker::Avatar.image,
                    :contents => Faker::Lorem.paragraph)
    end
  end
end