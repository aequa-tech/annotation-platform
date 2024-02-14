module Management
  class AnnotatorSearchForm < ::BaseSearchForm
    set_condition :id_eq, :fullname_full_like, :email_full_like

    def perform(page = nil, limit: nil, csv: false)
      records = Annotator.distinct
      records = apply_conditions(records, page, limit, csv)
      apply_sort(records, Annotator.primary_key)
    end
  end
end
