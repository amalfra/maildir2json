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

      it 'errors when input file given does not exists' do
        expect do
          ARGV.replace ['/my-system/testfile.maildir', '/my-system/output.json']
          Maildir2Json.validate_params
        rescue SystemExit # rubocop:disable Lint/SuppressedException
        end.to output(/The input file you have specified does not exist!/i).to_stderr_from_any_process
      end

      it 'passes when all good' do
        FileUtils.rm('/tmp/testfile.maildir', force: true)
        ARGV.replace ['/tmp/testfile.maildir', '/my-system/output.json']
        FileUtils.touch('/tmp/testfile.maildir')

        begin
          expect { Maildir2Json.validate_params }.not_to raise_error
        rescue RSpec::Expectations::ExpectationNotMetError => e
          expect(e.message).not_to include 'SystemExit'
        end
        FileUtils.rm('/tmp/testfile.maildir', force: true)
      end
    end
  end
end
