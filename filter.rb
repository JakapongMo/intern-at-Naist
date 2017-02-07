require 'open-uri'
require 'csv'

$nb_data = 1000
$data_path = '/home/tengmo/Naist/csv/edges.csv'
#$nb_data = 109447
#$data_path = '/home/tengmo/Naist/output/edges1.csv'



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
  CSV.foreach($data_path) do |row|
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

freq = Create_array_source()

freq = Find_freq(freq)
#puts freq

new_array = Create_new_array(freq)

puts new_array
