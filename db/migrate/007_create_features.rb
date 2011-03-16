migration 7, :create_features do
  up do
    create_table :features do
      column :id, Integer, :serial => true
      column :name, String
      column :description, Text
      column :created, DateTime
      column :category, String
      column :cost, Integer
      column :status, String
    end
  end

  down do
    drop_table :features
  end
end
