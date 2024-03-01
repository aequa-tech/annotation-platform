module Management
  class TextLineSearchForm < ::BaseSearchForm
    set_condition :id_eq

    def perform(page = nil, limit: nil, csv: false)
      records = TextLine.distinct
      records = apply_conditions(records, page, limit, csv)
      apply_sort(records, TextLine.primary_key)
    end
  end
end
