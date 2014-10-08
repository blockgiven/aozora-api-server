require 'nkf'
require 'open-uri'

module AozoraLibrary
  class Book
    include Enumerable

    def initialize(book_hash)
      @book_hash = book_hash
    end

    def each
      text.split(/。/).each do |sentence|
        yield "#{sentence}。".gsub(/(?:^　+|　+$|\n|\r)/, '').chomp
      end
    end

    def url
      @book_hash['XHTML/HTMLファイルURL']
    end

    def text
      raw_text.gsub(/［＃[^］]*］/, '')
    end

    def title
      @book_hash['作品名']
    end

    private

    def html
      @html ||= NKF.nkf('-w', open(url).read)
    end

    def raw_text
      Nokogiri::HTML.parse(html).at_css('.main_text').text
    end
  end
end
