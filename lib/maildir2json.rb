# frozen_string_literal: true

require 'json'
require 'mail'
require_relative 'hash'

# Maildir2Json is the main entry point of execution
module Maildir2Json
  def self.validate_params
    abort("\e[31mYou need to provide absolute path to input file\e[0m") if ARGV.empty?
    abort("\e[31mYou need to provide absolute path to output file\e[0m") if ARGV.length < 2

    @input_file = ARGV[0]
    @output_file = ARGV[1]

    abort("\e[31mThe input file you have specified does not exist!\e[0m") unless File.exist?(@input_file)
  end

  def self.run
    validate_params
    mail = Mail.read(@input_file)
    data = YAML.safe_load(mail.to_yaml, [Symbol, Mail::SMTP, Mail::Body])

    data = data.to_utf8

    begin
      json = JSON.dump(data)
    rescue StandardError
      abort("\e[31mError converting maildir file #{INPUT_FILE}\e[0m")
    end

    File.write(@output_file, json)
  end
end
