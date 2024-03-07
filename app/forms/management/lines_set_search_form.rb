module Management
  class LinesSetSearchForm < ::BaseSearchForm
    set_condition :id_eq

    def perform(page = nil, limit: nil, csv: false)
      records = LinesSet.distinct
      records = apply_conditions(records, page, limit, csv)
      apply_sort(records, LinesSet.primary_key)
    end
  end
end
