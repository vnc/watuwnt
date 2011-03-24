require 'net/ldap'

class Account
  include DataMapper::Resource
  include DataMapper::Validate
  attr_accessor :password, :password_confirmation

  # Properties
  property :id,               Serial
  property :name,             String
  property :surname,          String
  property :email,            String, :length => 100
  # BCrypt gives you a 60 character string
  property :crypted_password, String, :length => 60
  property :role,             String
  property :ldap_account,     String

  has n, :votes
  has n, :features

  # Validations
  validates_presence_of      :email
  validates_presence_of      :role
  validates_presence_of      :password,                          :if => :password_required
  validates_presence_of      :password_confirmation,             :if => :password_required
  validates_length_of        :password, :min => 4, :max => 40,   :if => :password_required
  validates_confirmation_of  :password,                          :if => :password_required
  validates_length_of        :email,    :min => 3, :max => 100
  validates_uniqueness_of    :email,    :case_sensitive => false
  #validates_format_of        :email,    :with => :email_address
  validates_format_of        :role,     :with => /[A-Za-z]/

  # Callbacks
  before :save, :encrypt_password

  ##
  # This method is for authentication purpose
  #
  def self.authenticate(login, password)
    account = first(:conditions => { :email => login }) if login.present?
    if account
      if ldap_authenticated(login,password)
        return account # in local db, successful ldap auth
      else
        return nil # in local db, bad ldap auth
      end
    else
      if ldap_authenticated(login,password)
        return create_account(login,password,"user") # not in local db, successful ldap auth
      else
        return nil # not in local db, bad ldap auth
      end
    end
  end
  
  def create_account(login,password,role)
    @account = Account.new({ :email => login, :password => "decoy", :role => role, :ldap_account => login })
    if @account.save
      return @account
    else
      return nil
    end
  end

  ##
  # This method is used by AuthenticationHelper
  #
  def self.find_by_id(id)
    get(id) rescue nil
  end

  def has_password?(password)
    ::BCrypt::Password.new(crypted_password) == password
  end
  
  def is_admin?
    self.role == "admin"
  end
  
  def initial_votes
    100
  end
  
  def vote_balance
    total_votes = self.initial_votes
    self.votes.each do |vote|
      total_votes = total_votes - vote.credits
    end
    total_votes
  end
  
  def ldap_authenticated?(login, password)
    return false if password.blank?
    ldap_host = '10.244.26.69'
    ldap_port = 636
    
    ldap = Net::LDAP.new
    ldap.host = ldap_host
    ldap.port = ldap_port
    ldap.authenticate login, password
    ldap.encryption :simple_tls
    
    if ldap.bind
      true
    else
      nil
    end
    
  end

  private
    def password_required
      crypted_password.blank? || password.present?
    end

    def encrypt_password
      self.crypted_password = ::BCrypt::Password.create(password) if password.present?
    end
end
