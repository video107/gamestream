namespace :dev do

  task :fake => :environment do
    Menu.delete_all
    User.delete_all
    Category.delete_all
    Category.create(:name=>"三國類")
    Category.create(:name=>"轉珠類")
    Category.create(:name=>"動作類")
    Category.create(:name=>"腳色扮演")
    website = ["http://www.yahoo.com.tw", "http://www.google.com.tw", "http://www.pchome.com.tw", "http://www.facebook.com.tw"]
    10.times do |i|
        puts "fake #{i}"
        Menu.create!( :name => Faker::App.name,
                      :contents => Faker::Lorem.paragraph,
                      :menu_url => website.sample,
                      :category_id => Category.all.sample.id  )
    end
  end


  task :fix_friendly_id => :environment do
    Menu.all.each do |e|
      e.friendly_id = SecureRandom.hex(10)
      e.save!
    end
    User.all.each do |e|
      e.friendly_id = SecureRandom.hex(10)
      e.save!
    end
    Case.all.each do |e|
      e.friendly_id = SecureRandom.hex(10)
      e.save!
    end
  end


end
