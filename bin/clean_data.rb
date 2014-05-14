require 'csv'
require "awesome_print"

def extract_postcode(address)
  address_parts = address.split(',')
  match = /(DUBLIN \d+)/.match(address_parts.last)
  if match
    return match[1].capitalize
  end
end

def remove_commas(string)
  string.gsub(',','')
end

CSV.open('data/PPR-2014-Dublin_cleaned.csv', 'w') do |csv_output|
  
  File.open("data/PPR-2014-Dublin.csv").each do |line|
    line.encode!("UTF-8", :invalid => :replace, :undef => :replace, :replace => "")
    
    fields = CSV.parse_line(line)
    fields[2] = extract_postcode(fields[1]) || fields[2]
    fields[4] = remove_commas(fields[4])
    csv_output << fields
  end
end

