require 'open-uri'
require 'csv'


$data_path_all_data = '/home/tengmo/Naist/output/alldata/all_data1.csv'


def Create_hash_id_in()
  hash_id = Hash.new()
    CSV.foreach($data_path_all_data ,{:headers=>:first_row}) do |row|
        if Integer(row[2]) != 0 and Integer(row[3]) != 0
            hash_id[Integer(row[0])] = Integer(row[3])
        end
    end
  return hash_id
end


def Create_Top30_in_sumdownload(both_id)
  both_id = both_id.sort_by { |key, v | -v}.first(30)

  result_hash_id = Hash.new(0)

  both_id.each do |key, value|
    result_hash_id[key] = value
  end

  result_hash_id.each do |key, value|
    #puts "#{key} : #{value}"
  end
  sum = 0
  CSV.foreach($data_path_all_data ,{:headers=>:first_row}) do |row|
        if result_hash_id.key?(Integer(row[0]))
            sum += Integer(row[4])
        end
  end
  return sum
end

def Create_hash_id_all()
  hash_id = Hash.new()
      #CSV.foreach($data_path_all_data ,{:headers=>:first_row}) do |row|
            hash_id[5202] = 0
            hash_id[29110] = 0
            hash_id[56736] = 0
            hash_id[64092] = 0
            hash_id[66142] = 0
            hash_id[86910] = 0
            hash_id[108952] = 0
            hash_id[109014] = 0
      #  end
  return hash_id
end

def Create_all_sumdownload(both_id)

  result_hash_id = Hash.new(0)

  both_id.each do |key, value|
    result_hash_id[key] = value
  end

  result_hash_id.each do |key, value|
    #puts "#{key} : #{value}"
  end
  sum = 0
  CSV.open("/home/tengmo/Naist/output/Downloads.csv", 'wb') do |csv|
      csv << ["Downloads"]
      CSV.foreach($data_path_all_data ,{:headers=>:first_row}) do |row|
          if !(result_hash_id.key?(Integer(row[0])))
              csv << [row[4]]
              sum += Integer(row[4])
            end
          end
          return sum
  end
end

#########################################-main-###############################

in_id = Create_hash_id_in()

all_id = Create_hash_id_all()
sum = Create_all_sumdownload(all_id)
sum2 = Create_Top30_in_sumdownload(in_id)
puts "Total all Dowload  Gem : #{sum2}"
puts "Total in Dowload Top30  Gem : #{sum}"

puts Float((Float(sum2)/Float(sum))*100)
