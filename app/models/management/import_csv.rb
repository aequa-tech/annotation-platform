# frozen_string_literal: true

module Management
  class ImportCsv
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :klass, default: nil
    attribute :csv_file, default: nil
    attribute :headers, default: true

    def valid?
      klass.present? && csv_file.present?
    end

    def import
      CSV.parse(@csv_file, headers: @headers) do |row|
        @klass.invite!(email: row["email"], fullname: row["fullname"], editor_id: current_editor.id)
      end
    end
  end
end
