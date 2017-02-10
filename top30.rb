require 'open-uri'
require 'csv'


#$data_path_all_data = '/home/tengmo/Naist/output/testdata/all_data.csv'
#$data_path_node = '/home/tengmo/Naist/output/testdata/node.csv'
#$data_path_edges = '/home/tengmo/Naist/output/testdata/edges.csv

$data_path_all_data = '/home/tengmo/Naist/output/alldata/all_data1.csv'
$data_path_node = '/home/tengmo/Naist/output/alldata/node1.csv'
$data_path_edges = '/home/tengmo/Naist/output/alldata/edges1.csv'


def Create_hash_id_both_in_out()
  hash_id = Hash.new()
    CSV.foreach($data_path_all_data ,{:headers=>:first_row}) do |row|
        if Integer(row[2]) != 0 and Integer(row[3]) != 0
            hash_id[Integer(row[0])] = Integer(row[2])+ Integer(row[3])
        end
    end
  return hash_id
end



def Create_hash_id_out()
  hash_id = Hash.new()
    CSV.foreach($data_path_all_data ,{:headers=>:first_row}) do |row|
        if Integer(row[2]) != 0 and Integer(row[3]) != 0
            hash_id[Integer(row[0])] = Integer(row[2])
        end
    end
  return hash_id
end

def Create_hash_id_in()
  hash_id = Hash.new()
    CSV.foreach($data_path_all_data ,{:headers=>:first_row}) do |row|
        if Integer(row[2]) != 0 and Integer(row[3]) != 0
            hash_id[Integer(row[0])] = Integer(row[3])
        end
    end
  return hash_id
end

def Create_Top30_both_edges(both_id)
  both_id = both_id.sort_by { |key, v | -v}.first(30)

  result_hash_id = Hash.new(0)

  both_id.each do |key, value|
    result_hash_id[key] = value
  end

  result_hash_id.each do |key, value|
    #puts "#{key} : #{value}"
  end

  CSV.open("/home/tengmo/Naist/output/Top30_both_edges.csv", "wb") do |csv|
    csv << ["Source", "Target"]
    CSV.foreach($data_path_edges ,{:headers=>:first_row}) do |row|
          if result_hash_id.key?(Integer(row[0])) and result_hash_id.key?(Integer(row[1]))
            csv << [row[0], row[1]]
          end
    end
  end
end

def Create_Top30_both_node(both_id)
  both_id = both_id.sort_by { |key, v | -v}.first(30)

  result_hash_id = Hash.new(0)

  both_id.each do |key, value|
    result_hash_id[key] = value
  end

  result_hash_id.each do |key, value|
    #puts "#{key} : #{value}"
  end

  CSV.open("/home/tengmo/Naist/output/Top30_both_node.csv", "wb") do |csv|
    csv << ["id", "label"]
    CSV.foreach($data_path_node ,{:headers=>:first_row}) do |row|
          if result_hash_id.key?(Integer(row[0]))
            csv << [row[0], row[1]]
          end
    end
  end

end


def Create_Top30_out_edges(both_id)
  both_id = both_id.sort_by { |key, v | -v}.first(30)

  result_hash_id = Hash.new(0)

  both_id.each do |key, value|
    result_hash_id[key] = value
  end

  result_hash_id.each do |key, value|
    #puts "#{key} : #{value}"
  end

  CSV.open("/home/tengmo/Naist/output/Top30_out_edges.csv", "wb") do |csv|
    csv << ["Source", "Target"]
    CSV.foreach($data_path_edges ,{:headers=>:first_row}) do |row|
          if result_hash_id.key?(Integer(row[0])) and result_hash_id.key?(Integer(row[1]))
            csv << [row[0], row[1]]
          end
    end
  end
end

def Create_Top30_out_node(both_id)
  both_id = both_id.sort_by { |key, v | -v}.first(30)

  result_hash_id = Hash.new(0)

  both_id.each do |key, value|
    result_hash_id[key] = value
  end

  result_hash_id.each do |key, value|
    #puts "#{key} : #{value}"
  end

  CSV.open("/home/tengmo/Naist/output/Top30_out_node.csv", "wb") do |csv|
    csv << ["id", "label"]
    CSV.foreach($data_path_node ,{:headers=>:first_row}) do |row|
          if result_hash_id.key?(Integer(row[0]))
            csv << [row[0], row[1]]
          end
    end
  end

end

def Create_Top30_in_edges(both_id)
  both_id = both_id.sort_by { |key, v | -v}.first(30)

  result_hash_id = Hash.new(0)

  both_id.each do |key, value|
    result_hash_id[key] = value
  end

  result_hash_id.each do |key, value|
    #puts "#{key} : #{value}"
  end

  CSV.open("/home/tengmo/Naist/output/Top30_in_edges.csv", "wb") do |csv|
    csv << ["Source", "Target"]
    CSV.foreach($data_path_edges ,{:headers=>:first_row}) do |row|
          if result_hash_id.key?(Integer(row[0])) and result_hash_id.key?(Integer(row[1]))
            csv << [row[0], row[1]]
          end
    end
  end
end

def Create_Top30_in_node(both_id)
  both_id = both_id.sort_by { |key, v | -v}.first(30)

  result_hash_id = Hash.new(0)

  both_id.each do |key, value|
    result_hash_id[key] = value
  end

  result_hash_id.each do |key, value|
    #puts "#{key} : #{value}"
  end

  CSV.open("/home/tengmo/Naist/output/Top30_in_node.csv", "wb") do |csv|
    csv << ["id", "label"]
    CSV.foreach($data_path_node ,{:headers=>:first_row}) do |row|
          if result_hash_id.key?(Integer(row[0]))
            csv << [row[0], row[1]]
          end
    end
  end

end





################################-main-#####################################

both_id = Create_hash_id_both_in_out()

out_id = Create_hash_id_out()
in_id = Create_hash_id_in()

Create_Top30_both_edges(both_id)
Create_Top30_both_node(both_id)

Create_Top30_out_edges(out_id)
Create_Top30_out_node(out_id)

Create_Top30_in_edges(in_id)
Create_Top30_in_node(in_id)
