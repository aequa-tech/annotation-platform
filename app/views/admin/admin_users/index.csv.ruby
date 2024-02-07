require "csv"

CSV.generate do |csv|
  # set title row
  csv << []
  # set body rows
  @admin_users.each do |admin_user|
    csv << []
  end
end
