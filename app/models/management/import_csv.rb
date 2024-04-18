# frozen_string_literal: true

module Management
  class ImportCsv
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :klass, default: nil
    attribute :csv_file, default: nil
    attribute :headers, default: true

    REQUIRED_HEADERS = ["email", "fullname"]

    def valid?
      klass.present? && csv_file.present? && valid_headers?
    end

    def valid_headers?
      csv = CSV.open(csv_file)
      csv_headers = csv.shift
      csv.close
      REQUIRED_HEADERS - csv_headers == []
    end
  end
end
