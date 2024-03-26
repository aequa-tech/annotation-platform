module Management
  class TaxonomySearchForm < ::BaseSearchForm
    set_condition :id_eq, :title_full_like, :description_full_like, :editor_id_eq

    def perform(scope = nil, page = nil, limit: nil, csv: false)
      records = scope
      records = apply_conditions(records, page, limit, csv)
      apply_sort(records, Taxonomy.primary_key)
    end
  end
end
