Hanami::Model.migration do
  change do
    create_table :tweets do
      primary_key :id

      column :contents, String, null: false
      # column :author_id, Integer, null: false
      foreign_key :author_id, :users, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
