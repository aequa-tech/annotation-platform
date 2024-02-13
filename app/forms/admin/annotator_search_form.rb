module Admin
  class AnnotatorSearchForm < BaseSearchForm
    set_condition :id_eq,
      :fullname_full_like,
      :email_full_like,
      :editor_id_eq

    def perform(page = nil, limit: nil, csv: false)
      records = Annotator.includes(:editor).distinct
      records = apply_conditions(records, page, limit, csv)
      apply_sort(records, Annotator.primary_key)
    end

    def editor_fullname
      Editor.find(editor_id_eq)&.fullname if editor_id_eq.present?
    end
  end
end
