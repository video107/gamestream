namespace :dev do

  task :fake => :environment do
    Menu.delete_all
    User.delete_all
    website = ["http://www.yahoo.com.tw", "http://www.google.com.tw", "http://www.pchome.com.tw", "http://www.facebook.com.tw"]
    10.times do |i|
        puts "fake #{i}"
        Menu.create!( :name => Faker::App.name,
                      :contents => Faker::Lorem.paragraph,
                      :menu_url => website.sample       )
    end
  end
end