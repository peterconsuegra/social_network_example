class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :twitter_account
  
  validates :body, length: {minimum: 1, maximun: 200}
  validates :publish_at, presence: true
  
  after_initialize do
    #si este valor es diferente de nil y vacio dejarlo. Sino asignarle lo siguiente
    self.publish_at ||= 24.hours.from_now
  end
  
  after_save_commit do
    if publish_at_previously_changed?
       TweetJob.set(wait_until: publish_at).perform_later(self)
    end
  end
  
  def published?
    #If have question mark, it will return true or false
    tweet_id?
  end
  
  def publish_to_twitter!
    tweet = twitter_account.client.update(body)
    update(tweet_id: tweet.id)
  end
  
  
end
