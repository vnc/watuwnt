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
  
  def voted?(user_id)
    accounts.each do |account|
      return true if account.id == user_id
    end
  end
  
  def vote_count
    count = 0
    votes.each { |vote| count += vote.credits }
    (cost != 0) ? count / cost : 0
  end
end