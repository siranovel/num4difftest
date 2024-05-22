from requests_oauthlib import OAuth1Session
import os

CONSUMER_KEY = os.environ.get("TWITTER_CONSUMER_KEY")
CONSUMER_SECRET = os.environ.get("TWITTER_CONSUMER_SECRET")
ACCESS_KEY = os.environ.get("TWITTER_ACCESS_TOKEN")
ACCESS_KEY_SECRET = os.environ.get("TWITTER_ACCESS_TOKEN_SECRET")
tweet = 'New commit pushed! (twitter v2 oauth 1.0a)'

url_text = 'https://api.twitter.com/2/tweets'
def main():
    #
    twitter = OAuth1Session(CONSUMER_KEY, 
                       client_secret = CONSUMER_SECRET,
                       resource_owner_key=ACCESS_KEY,
                       resource_owner_secret=ACCESS_KEY_SECRET
                       )
    res = twitter.post(url_text, json={"text": tweet})                       
    #
    print(res)
    print(res.text)
                        
    
if __name__ == "__main__":
    main()

