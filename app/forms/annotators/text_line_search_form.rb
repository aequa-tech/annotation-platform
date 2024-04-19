module Annotators
  class TextLineSearchForm < ::BaseSearchForm
    set_condition :id_eq, :lines_set_id_eq, :corpus_id_eq

    def perform(scope = nil, page = nil, limit: nil, csv: false)
      records = scope
      records = apply_conditions(records, page, limit, csv)
      apply_sort(records, TextLine.primary_key)
    end
  end
end
