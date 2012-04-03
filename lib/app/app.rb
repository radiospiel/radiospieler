module App
  extend self

  def env
    ENV["RACK_ENV"] || ENV["RAILS_ENV"] || "development"
  end
end

Dir.glob("#{File.dirname(__FILE__)}/app/*.rb").sort.each do |file|
  load file
end
