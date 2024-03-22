module Management
  class CorpusSearchForm < ::BaseSearchForm
    set_condition :id_eq, :title_full_like, :editor_id_eq

    def perform(page = nil, limit: nil, csv: false)
      records = Corpus.distinct
      records = apply_conditions(records, page, limit, csv)
      apply_sort(records, Corpus.primary_key)
    end
  end
end
