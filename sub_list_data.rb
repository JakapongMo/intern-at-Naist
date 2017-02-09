require 'open-uri'
require 'csv'

#$data_path_all_data = '/home/tengmo/Naist/output/testdata/all_data.csv'
#$data_path_node = '/home/tengmo/Naist/output/testdata/node.csv'
#$data_path_edges = '/home/tengmo/Naist/output/testdata/edges.csv'

$data_path_all_data = '/home/tengmo/Naist/output/alldata/all_data1.csv'
$data_path_node = '/home/tengmo/Naist/output/alldata/node1.csv'
$data_path_edges = '/home/tengmo/Naist/output/alldata/edges1.csv'



def Create_list_reducndance_node()

  CSV.open("/home/tengmo/Naist/output/sub_list.csv", "wb") do  |csv|
    csv << ["id", "label","out", "in", "Downloads"]
    CSV.foreach($data_path_all_data ,{:headers=>:first_row}) do |row|
        if Integer(row[2]) != 0 and Integer(row[3]) != 0
            csv << [row[0] , row[1], row[2], row[3], row[4]]
        end
    end
  end
end


###############-main-#############################

Create_list_reducndance_node()

##################################################
