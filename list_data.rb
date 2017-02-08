require 'open-uri'
require 'csv'

$data_path_node = '/home/tengmo/Naist/csv/node.csv'
$data_path_edges = '/home/tengmo/Naist/csv/edges.csv'
$data_path_node_with_download = '/home/tengmo/Naist/output/testdata/node_with_download.csv'


hash_outgoing = Hash.new(0)
hash_ingoing = Hash.new(0)

cnt = 0
CSV.foreach($data_path_node) do |row|
  cnt +=1
  next if cnt == 1
  hash_outgoing[row[0]] = 0
  hash_ingoing[row[0]] = 0
end

cnt =0
CSV.foreach($data_path_edges) do |row|
  cnt +=1
  next if cnt == 1
  #puts "#{row[0]} : #{row[1]}"
  if hash_outgoing.key?(row[0])
    hash_outgoing[row[0]] += 1
  else
    hash_outgoing[row[0]] = 1
  end

  if hash_ingoing.key?(row[1])
    hash_ingoing[row[1]] +=1
  else
    hash_ingoing[row[1]] = 1
  end

end
#hash_ingoing[1]

#puts 'outgoing'
#hash_outgoing.each do |key, value|
#  puts "key = #{key} : value = #{value}"
#end

#puts 'ingoing'
#hash_ingoing.each do |key, value|
#  puts "key = #{key} : value = #{value}"
#end

CSV.open("/home/tengmo/Naist/output/all_data.csv", 'wb') do |csv|
 csv << ["id", 'label', 'outgoing', 'ingoing', 'Downloads']
  cnt = 0
  CSV.foreach($data_path_node_with_download) do |subcsv|
  cnt += 1
    next if cnt == 1
    hash_outgoing.each do |key , value|
      if key == subcsv[0]
        hash_ingoing.each do |subkey, subvalue|
          if subkey == subcsv[0]
            csv << [subcsv[0], subcsv[1], value, subvalue, subcsv[2]]
            break
          end
        end
        break
      end
    end
    end
  end
