class Feature
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :name, String
  property :description, Text
  property :created, DateTime
  property :category, String
  property :cost, Integer
  property :status, String
  
  has n, :votes
  has n, :accounts, :through => :votes
  belongs_to :account
end
