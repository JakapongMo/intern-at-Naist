require 'open-uri'
require 'csv'

#$nb_data = 1000
#$data_path_edges = '/home/tengmo/Naist/csv/edges.csv'
#$data_path_node = '/home/tengmo/Naist/csv/node.csv'
$nb_data = 109447
$data_path_edges = '/home/tengmo/Naist/output/edges1.csv'
$data_path_edges = '/home/tengmo/Naist/output/node1.csv'


def Create_array_source()
  array = Array.new

  for x in 1..$nb_data
    array[x] = 0
  end
  return array
end

def Find_freq(freq)
  array = Array.new
  cnt = 0
  CSV.foreach($data_path_edges) do |row|
    cnt +=1
    next if cnt == 1
    freq[Integer(row[1])] += 1
  #  puts row[1]
  end
  return freq
end

def Create_new_array(freq)
  count = 0
  new_array = Array.new
  for x in 1..$nb_data
    if freq[x] != 0
      new_array[count] = x
      count +=1
    end
  end
  return new_array
end

def Create_filter_edges(new_array)
  CSV.open("/home/tengmo/Naist/output/edges-filter.csv", 'wb') do |csv|
      csv << ["Source", 'Target']
    #   csv << [,]
        cnt =0
        CSV.foreach($data_path_edges) do |row|
          cnt +=1
          next if cnt == 1
          new_array.each do |element|
              if element.to_s == row[0].to_s
                csv << [row[0],row[1]]
              end
          end
        end
  end
end

def Create_filter_node(new_array)
  CSV.open("/home/tengmo/Naist/output/node-filter.csv", 'wb') do |csv|
      csv << ["id", 'label']
    #   csv << [,]
        cnt =0
        CSV.foreach($data_path_node) do |row|
          cnt +=1
          next if cnt == 1
          new_array.each do |element|
              if element.to_s == row[0].to_s
                csv << [row[0],row[1]]
              end
          end
        end
  end
end

############################-mian-#########################################

freq = Create_array_source()

freq = Find_freq(freq)
#puts freq
new_array = Create_new_array(freq)
#puts new_array
Create_filter_edges(new_array)
Create_filter_node(new_array)
###########################################################################
