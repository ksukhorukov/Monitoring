require 'yaml'
require 'ostruct'

config = YAML.load_file("./config/config.yml")
Settings = OpenStruct.new(config)