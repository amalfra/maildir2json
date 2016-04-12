#!/usr/bin/env ruby

#  A simple script to convert maildir format file into JSON. Will accept
#  input file in maildir format and output equivalent JSON into
#  specified file.
#
#  Usage: maildir2json.rb <full path to input file> <full path to output file>

# These gems are required
requirements = %w(mail json)
requirements_installed = {}
# Find which all version of our required gems are already installed
Gem::Specification.find_all.each do |spec|
    if requirements.include? spec.name
        requirements_installed[spec.name] = spec.version.to_s
    end
end

# Install missing requirement gems
if requirements_installed.length <= requirements.length
    requirements.each do |req|
        next if requirements_installed.key? req
        puts "Requirement '#{req}' not satisfied; installing..."
        require 'rubygems/commands/install_command'

        begin
            cmd = Gem::Commands::InstallCommand.new
            cmd.handle_options [req]

            cmd.execute
        rescue Gem::SystemExitException => e
            puts "FAILURE: #{e.exit_code}" if e.exit_code > 0
        end
    end
end

# Now load all required gems
requirements.each(&method(:require))

# This helper function will convert all hash values into UTF8
class Hash
    def to_utf8
        Hash[
          collect do |k, v|
              if v.respond_to?(:to_utf8)
                  [k, v.to_utf8]
              elsif v.respond_to?(:encoding)
                  [k, v.dup.encode('UTF-8', invalid: :replace,
                                            undef: :replace,
                                            replace: '?')]
              else
                  [k, v]
              end
          end
        ]
    end
end

if ARGV.empty?
    abort("\e[31mYou need to provide absolute path to input file\e[0m")
end

if ARGV.length < 2
    abort("\e[31mYou need to provide absolute path to output file\e[0m")
end

INPUT_FILE = ARGV[0]
OUTPUT_FILE = ARGV[1]

# Throw error if input file does not exist
unless File.exist?(INPUT_FILE)
    abort("\e[31mThe input file you have specified does not exist!\e[0m")
end

mail = Mail.read(INPUT_FILE)
data = YAML.load(mail.to_yaml)
# Convert all values into UTF8
data = data.to_utf8
# Convert to JSON format
begin
    json = JSON.dump(data)
rescue
    abort("\e[31mError converting maildir file #{INPUT_FILE}\e[0m")
end
# Write JSON file to user specified path
File.write(OUTPUT_FILE, json)
