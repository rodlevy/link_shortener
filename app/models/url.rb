class Url < ActiveRecord::Base
    
  before_create :shorten 
  validates   :url, :presence => :true
  validates   :url, :uniqueness   => :true
  validate   :check_valid_url
# on custom validate its singular

  def shorten
    self.url_short = SecureRandom.hex(5)
  end

  def check_valid_url
    return self if url.nil?
    match = self.url.match URI.regexp(['http', 'https'])
    unless match
      errors[:url] << "The URL is not valid"
    end
  end
end
