class Vote
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :date, DateTime
  property :credits, Integer
  
  belongs_to :feature
  belongs_to :account
end
