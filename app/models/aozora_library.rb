require 'csv'

module AozoraLibrary
  def self.books
    @books ||= index_csv.map {|row| Book.new(row) }
  end

  private

  def self.index_csv
    CSV.open(index_csv_path, headers: :first_row)
  end

  def self.index_csv_filename
    original_filename = "list_person_all_extended_utf8.csv"
    File.basename(ActionController::Base.helpers.asset_path(original_filename))
  end

  def self.index_csv_path
    Rails.root.join(
      'public',
      'assets',
      index_csv_filename
    )
  end
end
