namespace :export do
  desc "Prints Line.all, Stop.all, Vehicle.all in a seeds.rb way."
  task :seeds_format => :environment do
    #this array holds models for the app
    #Line, Stop, Vehicle, User, Setting
    [User, Setting].each do |model|
      model.order(:id).all.each do |data|
        puts "#{model}.create(#{data.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
      end
      puts
    end
  end
end
# method was adapted from http://www.xyzpub.com/en/ruby-on-rails/3.2/seed_rb.html
#.gsub(/#.+?,'/,'').gsub(/',.+?\>/,'') regex to replace BigDecimal.inspect syntax, but time-consuming to run in loop
#https://stackoverflow.com/questions/31178626/how-to-parse-ruby-bigdecimal-inspect
#http://railscasts.com/episodes/179-seed-data?view=asciicast
#use this in the CLI: rake export:seeds_format > db/seeds2.rb
#filter BigDecimal with regex,
#use the following commands to find and/or replace BigDecimal.inspect syntax in rb file
##.+?' regex to find beginning syntax of BigDecimal
#',.+?> regex to find end syntax of BigDedcimal