module Annotators
  class TaskSearchForm < ::BaseSearchForm
    set_condition :id_eq, :lines_set_id_eq, :completed_eq, :annotator_id_eq

    def perform(scope = nil, page = nil, limit: nil, csv: false)
      records = scope
      records = apply_conditions(records, page, limit, csv)
      apply_sort(records, Task.primary_key)
    end
  end
end
