require 'open-uri'
require 'nokogiri'
require 'csv'
$data_directory_path = '/home/tengmo/Downloads/RubyGems/'
cnt = 0

def Find_license(license)
    ans = license.to_s
    array = Array.new
    start_0 = ''
    for index in 3..ans.length-5
      start_0 += ans[index]
    end
    array[0] = start_0
    return array[0]
end

def Find_download(download)
  start_0 = ''
  for x in 29..download.length-8
    next if download[x] == ','
    start_0 += download[x]
  end
  return start_0

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

def find_size(mainsize)
    start_0 = ''
    size = mainsize[0].to_s
    for x in 34..size.length-12
      start_0 +=  size[x]
    end
    begin
    if Float(start_0) or Integer(start_0)
      return start_0
    end
    rescue
      start_0 = ''
      size = mainsize[1].to_s
      for x in 34..size.length-12
        start_0 +=  size[x]
      end
      return start_0
    end

end


hash_removenode = Hash.new()

CSV.foreach("/home/tengmo/Naist/output/alldata/remove_redundance_node1.csv",{:headers=>:first_row}) do |item|
    hash_removenode[item[1]] = item[0]
end


#######################################-main-#################################

CSV.open("/home/tengmo/Naist/output/data_after_remove.csv", 'wb') do |csv|
    csv << ["id","lebel","size","Downloads","license"]
    Dir.foreach($data_directory_path) do |item|
      next if item == '.' or item == '..'
      #  item = '1_rake.html'
      doc = Nokogiri::HTML(open("#{$data_directory_path}#{item}"))
      title = doc.xpath("//head//title")
      title = Find_title(title)
      if hash_removenode.key?(title)
        size = doc.xpath("//li//span")
        size = find_size(size)
        download = doc.xpath("//span[@class = 'gem__downloads']")
        download = download[0].to_s
        download = Find_download(download)
        license  = doc.xpath("//span[@class = 'gem__ruby-version']//p")
        license = Find_license(license)
        begin
          if Float(size) or Integer(size)
            cnt += 1
            puts "#{cnt} : #{size}"
            csv << [hash_removenode[title], title, size, download, license]
          end
        rescue
          puts "skip : #{size}"
        end
      end

    end
end

=begin
sum = 0
cnt =0
my_hash.each do |key, value|
  cnt += 1
  begin
  if Float(value)
    sum = sum + Float(value)
    puts value
  end
  rescue
  end
end
puts sum
puts Float(sum/cnt)

=end
=begin
begin
  if Integer("222d2")
    puts "yoo"
  end
rescue
     puts "xxx"
end

#x =  x.class
puts "s"
=end
