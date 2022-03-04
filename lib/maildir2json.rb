require 'json'
require 'mail'
require_relative 'hash.rb'

module Maildir2Json
  abort("\e[31mYou need to provide absolute path to input file\e[0m") if ARGV.empty?
  abort("\e[31mYou need to provide absolute path to output file\e[0m") if ARGV.length < 2

  INPUT_FILE = ARGV[0]
  OUTPUT_FILE = ARGV[1]

  abort("\e[31mThe input file you have specified does not exist!\e[0m") unless File.exist?(INPUT_FILE)

  def self.run
    mail = Mail.read(INPUT_FILE)
    data = YAML.load(mail.to_yaml)

    data = data.to_utf8

    begin
      json = JSON.dump(data)
    rescue
      abort("\e[31mError converting maildir file #{INPUT_FILE}\e[0m")
    end

    File.write(OUTPUT_FILE, json)
  end
end
