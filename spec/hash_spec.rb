# frozen_string_literal: true

require 'hash'

describe Hash do
  describe '.to_utf8' do
    context 'given empty hash' do
      it 'returns input itself' do
        expect({}.to_utf8).to eq({})
      end
    end

    context 'given hash containing keys' do
      TEST_HASH_1 = {
        k1: "\x89",
        k2: 'utf8 str',
      }

      TEST_HASH_1_UTF8 = {
        k1: '?',
        k2: 'utf8 str',
      }

      it 'converts when non-utf8 values present' do
        expect(TEST_HASH_1.to_utf8).to eq(TEST_HASH_1_UTF8)
      end

      TEST_HASH_2 = {
        k1: 'utf8 str 1',
        k2: 'utf8 str',
      }

      TEST_HASH_2_UTF8 = {
        k1: 'utf8 str 1',
        k2: 'utf8 str',
      }

      it 'returns input when non-utf8 values not present' do
        expect(TEST_HASH_2.to_utf8).to eq(TEST_HASH_2_UTF8)
      end
    end
  end
end
