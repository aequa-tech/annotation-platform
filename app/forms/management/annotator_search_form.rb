module Management
  class AnnotatorSearchForm < ::BaseSearchForm
    set_condition :id_eq, :fullname_full_like, :email_full_like, :editor_id_eq

    def perform(scope = nil, page = nil, limit: nil, csv: false)
      records = scope
      records = apply_conditions(records, page, limit, csv)
      apply_sort(records, Annotator.primary_key)
    end
  end
end
