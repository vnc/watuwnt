migration 9, :add_fields_to_features do
  up do
    modify_table :features do
      add_column :account_id, Integer
    end
  end

  down do
    modify_table :features do
      drop_column :account_id
    end
  end
end
