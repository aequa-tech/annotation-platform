require "csv"

class ImportAnnotatorsJob < ActiveJob::Base
  queue_as :default

  def perform(current_editor_id, email:, fullname:)
    return if email.blank? || fullname.blank?
    return if Annotator.exists?(email: email.downcase)

    Annotator.invite!(email: email, fullname: fullname, editor_id: current_editor_id) # devise downcase email automatically
  end
end
