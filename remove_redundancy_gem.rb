require 'open-uri'
require 'csv'

#$data_path_all_data = '/home/tengmo/Naist/output/testdata/all_data.csv'
#$data_path_node = '/home/tengmo/Naist/output/testdata/node.csv'
#$data_path_edges = '/home/tengmo/Naist/output/testdata/edges.csv'

$data_path_all_data = '/home/tengmo/Naist/output/alldata/all_data1.csv'
$data_path_node = '/home/tengmo/Naist/output/alldata/node1.csv'
$data_path_edges = '/home/tengmo/Naist/output/alldata/edges1.csv'



def Create_remove_reducndance_node()
  hash_id = Hash.new()
  CSV.open("/home/tengmo/Naist/output/remove_redundance_node555.csv", "wb") do  |csv|
    csv << ["id", "label"]
    CSV.foreach($data_path_all_data ,{:headers=>:first_row}) do |row|
        if Integer(row[2]) != 0 and Integer(row[3]) != 0
            csv << [row[0] , row[1]]
            hash_id[Integer(row[0])] = 0
        end
    end
  end
  return hash_id
end



###############-main-#############################

hash_id = Create_remove_reducndance_node()
  CSV.open("/home/tengmo/Naist/output/remove_redundance_edges555.csv", "wb") do |csv|
    csv << ["Source", "Target"]
    CSV.foreach($data_path_edges ,{:headers=>:first_row}) do |row|
          if hash_id.key?(Integer(row[0])) and hash_id.key?(Integer(row[1]))
            csv << [row[0], row[1]]
          end
    end
  end
##################################################
