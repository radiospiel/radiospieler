require "micro_sql"

Dir.glob("#{File.dirname(__FILE__)}/core-extensions/*.rb").sort.each do |file|
  load file
end

Dir.glob("#{File.dirname(__FILE__)}/app/*.rb").sort.each do |file|
  load file
end

Dir.glob("#{File.dirname(__FILE__)}/extensions/*.rb").sort.each do |file|
  load file
end
