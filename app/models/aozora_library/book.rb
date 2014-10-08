require 'nkf'
require 'open-uri'
require 'zip'

module AozoraLibrary
  class Book
    include Enumerable

    def initialize(book_hash)
      @book_hash = book_hash
    end

    def each
      text.split(/(。|．)/).each do |sentence|
        yield sentence
      end
    end

    def text_url
      @book_hash['テキストファイルURL']
    end

    def text
      raw_text.split(headnote_separator)[2].gsub(/［＃[^］]*］/, '')
    end

    private

    def headnote_separator
      "-" * 55
    end

    def raw_text
      return @raw_text if @raw_text

      zipfile = open(text_url) do |zip|
        Tempfile.open(%w(csv .zip), encoding: Encoding::BINARY) do |zipfile|
          zipfile.write zip.read
          zipfile
        end
      end

      Zip::File.open(zipfile.path) do |zipfile|
        entry = zipfile.glob('**/*.txt').first
        @raw_text = NKF.nkf('-w', entry.get_input_stream.read)
      end

      @raw_text
    end
  end
end
