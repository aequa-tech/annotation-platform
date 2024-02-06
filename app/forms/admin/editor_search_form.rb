module Admin
  class EditorSearchForm < BaseSearchForm

    set_condition :id_eq,
                  :fullname_full_like

    def perform(page = nil, limit: nil, csv: false)
      records = Editor.distinct
      records = apply_conditions(records, page, limit, csv)
      apply_sort(records, Editor.primary_key)
    end
  end
end