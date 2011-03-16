migration 8, :create_votes do
  up do
    create_table :votes do
      column :id, Integer, :serial => true
      column :date, DateTime
      column :credits, Integer
    end
  end

  down do
    drop_table :votes
  end
end
