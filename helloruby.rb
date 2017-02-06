#!/usr/bin/ruby -w
require 'open-uri'
require 'nokogiri'
require 'csv'
def Find_depent(dependencies)
  array = Array.new
  input = 0
  start_0 = ''
  dependencies.each do |string|
      string = dependencies[input].to_s
      for index in 8..string.length-10
        start_0 += string[index]
      end
      array[input] = start_0
      input += 1
      start_0 = ''
  end
  return array
end

def Find_title(title)
    ans = title.to_s
    array = Array.new
    start_0 = ''
    for index in 7..ans.length-50
      start_0 += ans[index]
    end
    array[0] = start_0
    return array[0]
end

def Find_hash_file()
  my_hash = Hash.new("No information!")
  Dir.foreach('/home/tengmo/Naist/readfile') do |item|
      next if item == '.' or item == '..'
      doc = Nokogiri::HTML(open(item))
      dependencies = doc.xpath("//strong")
      title = doc.xpath("//head//title")
      test = Find_depent(dependencies)
      test2 = Find_title(title)
  #    puts "library : " + test2

      my_hash[test2] = test
  #    puts "nb of dependencies : " + my_hash[test2].length.to_s

      cnt = 0

      my_hash[test2].each do |element|
        cnt += 1
  #      puts "#{cnt}: #{element}"
      end

  #    puts
  end
  return my_hash
end

def Create_id()
  array = Array.new
  array[0] = "nothing here"
  cnt = 1
  Dir.foreach('/home/tengmo/Naist/readfile') do |item|
    next if item == '.' or item == '..'
    doc = Nokogiri::HTML(open(item))
    title = doc.xpath("//head//title")
    name_gem = Find_title(title)
    array[cnt] = name_gem
    cnt += 1
  end
  return array
end

def Create_node_csv(array_id)
  CSV.open("node.csv", 'wb') do |csv|
    csv << ["id", 'label']
    for x in 1..array_id.length-1
      csv << [x, array_id[x].to_s]
    end
  end

end

def Create_edges_csv(dependencies_hash, array_id)
  CSV.open("edges.csv", 'wb') do |csv|
      csv << ["Source", 'Target']
      dependencies_hash.each do |key , value|
          for  x in 0..value.length-1
            next if array_id.index(value[x]) == nil
            csv << [array_id.index(key), array_id.index(value[x])]
          end
      end
  end
end

def Print_gem_dependencies_with_number(dependencies_hash, array_id)
  dependencies_hash.each do |key , value|
      #puts key
      puts array_id.index(key).to_s + "::"
      for  x in 0..value.length-1
        next if array_id.index(value[x]) == nil
        puts array_id.index(value[x])
      end
      puts
  end
end

def Print_information()
  my_hash = Hash.new("No information!")
  Dir.foreach('/home/tengmo/Naist/readfile') do |item|
      next if item == '.' or item == '..'

      doc = Nokogiri::HTML(open(item))
      dependencies = doc.xpath("//strong")
      title = doc.xpath("//head//title")
      test = Find_depent(dependencies)
      test2 = Find_title(title)
      puts "library : " + test2

      my_hash[test2] = test
      puts "nb of dependencies : " + my_hash[test2].length.to_s

      cnt = 0

      my_hash[test2].each do |element|
        cnt += 1
        puts "#{cnt}: #{element}"
      end
      puts
  end
end

#def Find_version()
#  doc = Nokogiri::HTML(open('1_rake.html'))
#  version = doc.xpath("//body//main//div//h1//i")
#  #puts version
#  subversion = doc.xpath("//main//div//a[@class='t-list__item']")
#  puts subversion
#end

#Find_version()

############################ mian #################################

array_id = Create_id()
dependencies_hash = Find_hash_file()
Print_information()
Print_gem_dependencies_with_number(dependencies_hash, array_id)
Create_edges_csv(dependencies_hash, array_id)
Create_node_csv(array_id)

####################################################################
=begin

#puts array_id.index('resque')

#puts dependencies_hash[array_id[1]]
#  CSV.open("edges.csv", 'wb') do |csv|
#      csv << ["Source", 'Target']
#      dependencies_hash.each do |key , value|
#        #puts key
#        puts array_id.index(key).to_s + "::"
#        for  x in 0..value.length-1
#          next if array_id.index(value[x]) == nil
#         puts array_id.index(value[x])
#          csv << [array_id.index(key), array_id.index(value[x])]
#        end
#    puts
#  end

#end


#Dir.foreach('/home/tengmo/Naist/readfile') do |item|
#  next if item == '.' or item == '..'
 #item2 = item.to_s
 #Find_hash_file(item2)
#end

CSV.open("file.csv", 'wb') do |csv|
  cnt = 1
  csv << ["id", 'label']
  csv << [cnt.to_s, ]

end
=end
