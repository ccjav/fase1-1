require 'nokogiri'

def username
  doc = Nokogiri::HTML(File.open('twitter_account.html'))
  username = doc.search(".ProfileHeaderCard-name > a")
  puts "\e[#{1}m#{"\e[#{5}m#{"\e[#{7}m#{"\e[#{36}m#{"Username: #{username.first.inner_text}"}"}"}"}\e[0m"
end

def stats
  doc = Nokogiri::HTML(File.open('twitter_account.html'))
  tweets = doc.search('[data-nav="tweets"] > .ProfileNav-value')
  tweets = tweets.first.inner_text
  siguiendo = doc.search('[data-nav="following"] > .ProfileNav-value')
  siguiendo = siguiendo.first.inner_text
  seguidores = doc.search('[data-nav="followers"] > .ProfileNav-value')
  seguidores = seguidores.first.inner_text
  favoritos = doc.search('[data-nav="favorites"] > .ProfileNav-value')
  favoritos = favoritos.first.inner_text
  status_bar = "Stats: Tweets: #{tweets}, Siguiendo: #{siguiendo}, Seguidores: #{seguidores}, Favoritos: #{favoritos}"
  puts "\u2554" + "\u2550" * status_bar.length + "\u2557" 
  puts "\u2551" + status_bar + "\u2551"
  puts "\u255A" + "\u2550" * status_bar.length + "\u255D" 
  
end

def tweets
  doc = Nokogiri::HTML(File.open('twitter_account.html'))
  texto = doc.search('.tweet-text')
  fecha = doc.search('._timestamp')
  retweet = doc.search('[data-modal="ProfileTweet-retweet"] .ProfileTweet-actionCountForPresentation')
  favoritos = doc.search('.js-actionFavorite .ProfileTweet-actionCountForPresentation')
  puts "\e[#{4}m#{"Tweets:"}\e[0m\n\n"
  puts "\e[#{47}m#{"#{fecha[0].inner_text}.: #{texto[0].inner_text}"}\e[0m\n" + "\e[#{47}m#{"\e[#{36}m#{"\u267B"} #{retweet[0].inner_text}, \e[#{31}m#{"\u2665"} #{favoritos[0].inner_text}"}\e[0m \n\n"
  puts "\e[#{47}m#{"#{fecha[1].inner_text}.: #{texto[1].inner_text}"}\e[0m\n" + "\e[#{47}m#{"\e[#{36}m#{"\u267B"} #{retweet[2].inner_text}, \e[#{31}m#{"\u2665"} #{favoritos[2].inner_text}"}\e[0m \n\n"
  puts "\e[#{47}m#{"#{fecha[2].inner_text}.: #{texto[2].inner_text}"}\e[0m\n" + "\e[#{47}m#{"\e[#{36}m#{"\u267B"} #{retweet[4].inner_text}, \e[#{31}m#{"\u2665"} #{favoritos[4].inner_text}"}\e[0m \n\n"
end

username
stats
tweets
