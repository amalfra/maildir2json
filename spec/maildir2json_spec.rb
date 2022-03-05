# frozen_string_literal: true

require 'fileutils'
require 'maildir2json'

describe Maildir2Json do
  describe '.validate_params' do
    context 'given missing params' do
      it 'errors when no params given' do
        expect do
          Maildir2Json.validate_params
        rescue SystemExit # rubocop:disable Lint/SuppressedException
        end.to output(/You need to provide absolute path to input file/i).to_stderr_from_any_process
      end

      it 'errors when only first param given' do
        expect do
          ARGV.replace ['/my-system/testfile.maildir']
          Maildir2Json.validate_params
        rescue SystemExit # rubocop:disable Lint/SuppressedException
        end.to output(/You need to provide absolute path to output file/i).to_stderr_from_any_process
      end
    end

    context 'given all params' do
      it 'errors when input file given does not exists' do
        expect do
          ARGV.replace ['/my-system/testfile.maildir', '/my-system/output.json']
          Maildir2Json.validate_params
        rescue SystemExit # rubocop:disable Lint/SuppressedException
        end.to output(/The input file you have specified does not exist!/i).to_stderr_from_any_process
      end

      it 'passes when all good' do
        FileUtils.rm('/tmp/testfile.validate_params.maildir', force: true)
        ARGV.replace ['/tmp/testfile.validate_params.maildir', '/my-system/output.json']
        FileUtils.touch('/tmp/testfile.validate_params.maildir')

        begin
          expect { Maildir2Json.validate_params }.not_to raise_error
        rescue RSpec::Expectations::ExpectationNotMetError => e
          expect(e.message).not_to include 'SystemExit'
        end
        FileUtils.rm('/tmp/testfile.validate_params.maildir', force: true)
      end
    end
  end

  describe '.run' do
    context 'correct format input' do
      it 'fails to parse' do
        FileUtils.rm('/tmp/testfile.run.maildir', force: true)
        FileUtils.rm('/tmp/output.run.json', force: true)
        File.open('/tmp/testfile.run.maildir', 'w') do |f|
          f.write("
          section: 1
          content-type: multipart/alternative
          content-transfer-encoding: 8bit
          charset: UTF-8
          content-language: en-GB
          starting-pos: 0
          starting-pos-body: 2494
          ending-pos: 75170
          line-count: 1287
          body-line-count: 1241
          ")
        end

        ARGV.replace ['/tmp/testfile.run.maildir', '/tmp/output.run.json']
        expect { Maildir2Json.run }.not_to raise_error

        FileUtils.rm('/tmp/testfile.run.maildir', force: true)
        FileUtils.rm('/tmp/output.run.json', force: true)
      end
    end
  end
end
