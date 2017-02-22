require  'open-uri'
require 'csv'
require 'nokogiri'

$hash_license = Hash.new()

def Create_Top10_license(both_id)
  both_id = both_id.sort_by { |key, v | -v}.first(10)
  result_hash_id = Hash.new(0)

  both_id.each do |key, value|
    result_hash_id[key] = value
  end

  CSV.open("/home/tengmo/Naist/output/Top10_license", 'wb') do |csv|
      csv << ["license", "Frequency"]
        result_hash_id.each do |key, value|
          csv << [key,value]
        #  puts "#{key} : #{value}"
        end
  end
end


def Create_hash_license()
  CSV.foreach("/home/tengmo/Naist/output/data_after_remove.csv",{:headers=>:first_row})  do |row|
    #puts row[4]
    if $hash_license.key?(row[4])
      $hash_license[row[4]] += 1
    else
      $hash_license[row[4]] = 1
    end
  end
end


#################################-main-##############################################

Create_hash_license()
Create_Top10_license($hash_license)

#####################################################################################
