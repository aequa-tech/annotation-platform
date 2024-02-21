module Management
  class TaxonomySearchForm < ::BaseSearchForm
    set_condition :id_eq, :title_full_like, :description_full_like, :editor_id_eq

    def perform(page = nil, limit: nil, csv: false)
      records = Taxonomy.distinct
      records = apply_conditions(records, page, limit, csv)
      apply_sort(records, Taxonomy.primary_key)
    end
  end
end
