migration 10, :add_fields_to_vote do
  up do
    modify_table :votes do
      add_column :account_id, Integer
    add_column :feature_id, Integer
    end
  end

  down do
    modify_table :votes do
      drop_column :account_id
    drop_column :feature_id
    end
  end
end
