# frozen_string_literal: true

require_relative "iprog_export_model_to_xlsx/version"
require "axlsx"

module IprogExportModelToXlsx
  class Error < StandardError; end

  def export_to_xlsx(file_path = nil, options = {})
    exclude_columns = options[:exclude_columns] || []
    limit = options[:limit]
    conditions = options[:conditions] || ->(scope) { scope }
    sheet_name = options[:sheet_name] || name
    column_formats = options[:column_formats] || {}
    progress_callback = options[:progress_callback] || default_progress_callback
    filtered_file_path = file_path || "#{name.to_s.downcase}s.xlsx"

    attributes = attribute_names - exclude_columns

    workbook = Axlsx::Package.new
    workbook.workbook.add_worksheet(name: sheet_name) do |sheet|
      sheet.add_row(attributes.map(&:upcase))
      scope = all
      scope = conditions.call(scope)
      scope = scope.limit(limit) if limit
      total_records = scope.size
      scope.each_with_index do |record, index|
        row_data = record.attributes.slice(*attributes).map do |attr, value|
          column_formats[attr] ? column_formats[attr].call(value) : value
        end
        sheet.add_row(row_data)
        progress_callback.call(index + 1, total_records)
      end
    end
    workbook.serialize(filtered_file_path)
  rescue StandardError => e
    raise Iprog::Arde::Error, "Failed to export to XLSX: #{e.message}"
  end

  private

  def default_progress_callback
    ->(current, total) { puts "Exported #{current}/#{total} records" }
  end
end
