# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_04_30_144518) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "annotations", force: :cascade do |t|
    t.bigint "text_line_id", null: false
    t.bigint "annotator_id", null: false
    t.jsonb "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "task_id"
    t.index ["annotator_id"], name: "index_annotations_on_annotator_id"
    t.index ["task_id"], name: "index_annotations_on_task_id"
    t.index ["text_line_id"], name: "index_annotations_on_text_line_id"
  end

  create_table "annotators", force: :cascade do |t|
    t.string "fullname"
    t.string "email", default: "", null: false
    t.bigint "editor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["editor_id"], name: "index_annotators_on_editor_id"
    t.index ["email"], name: "index_annotators_on_email", unique: true
    t.index ["invitation_token"], name: "index_annotators_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_annotators_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_annotators_on_invited_by"
  end

  create_table "corpora", force: :cascade do |t|
    t.string "title"
    t.bigint "editor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["editor_id"], name: "index_corpora_on_editor_id"
  end

  create_table "corpora_taxonomies", force: :cascade do |t|
    t.bigint "corpus_id", null: false
    t.bigint "taxonomy_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["corpus_id", "taxonomy_id"], name: "index_corpora_taxonomies_on_corpus_id_and_taxonomy_id", unique: true
    t.index ["corpus_id"], name: "index_corpora_taxonomies_on_corpus_id"
    t.index ["taxonomy_id"], name: "index_corpora_taxonomies_on_taxonomy_id"
  end

  create_table "editors", force: :cascade do |t|
    t.string "fullname"
    t.string "email", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["email"], name: "index_editors_on_email", unique: true
    t.index ["invitation_token"], name: "index_editors_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_editors_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_editors_on_invited_by"
  end

  create_table "lines_sets", force: :cascade do |t|
    t.bigint "corpus_id", null: false
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["corpus_id", "title"], name: "index_lines_sets_on_corpus_id_and_title", unique: true
    t.index ["corpus_id"], name: "index_lines_sets_on_corpus_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "annotator_id", null: false
    t.bigint "lines_set_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "completed", default: false, null: false
    t.index ["annotator_id", "lines_set_id"], name: "index_tasks_on_annotator_id_and_lines_set_id", unique: true
    t.index ["annotator_id"], name: "index_tasks_on_annotator_id"
    t.index ["lines_set_id"], name: "index_tasks_on_lines_set_id"
  end

  create_table "taxonomies", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.bigint "editor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["editor_id"], name: "index_taxonomies_on_editor_id"
    t.index ["title", "editor_id"], name: "index_taxonomies_on_title_and_editor_id", unique: true
  end

  create_table "text_lines", force: :cascade do |t|
    t.string "external_id"
    t.text "content", null: false
    t.integer "position", null: false
    t.bigint "corpus_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "lines_set_id"
    t.index ["corpus_id"], name: "index_text_lines_on_corpus_id"
    t.index ["lines_set_id"], name: "index_text_lines_on_lines_set_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "annotations", "annotators"
  add_foreign_key "annotations", "tasks"
  add_foreign_key "annotations", "text_lines"
  add_foreign_key "annotators", "editors"
  add_foreign_key "corpora", "editors"
  add_foreign_key "corpora_taxonomies", "corpora"
  add_foreign_key "corpora_taxonomies", "taxonomies"
  add_foreign_key "lines_sets", "corpora"
  add_foreign_key "tasks", "annotators"
  add_foreign_key "tasks", "lines_sets"
  add_foreign_key "taxonomies", "editors"
  add_foreign_key "text_lines", "corpora"
  add_foreign_key "text_lines", "lines_sets"
end
