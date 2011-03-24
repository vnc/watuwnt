migration 11, :add_fields_to_accounts do
  up do
    modify_table :accounts do
      add_column :ldap_account, String
    end
  end

  down do
    modify_table :accounts do
      drop_column :ldap_account
    end
  end
end
