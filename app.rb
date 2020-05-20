require "sinatra"
require "sinatra/reloader"
require "httparty"
def view(template); erb template.to_sym; end

get "/" do

  ### Get the weather
  # Evanston, Kellogg Global Hub... replace with a different location if you want
  #lat = 42.0574063
  #long = -87.6722787
  #units = "imperial" # or metric, whatever you like
  #key = "512c72a4f3b368e1031146f0005347a7" # replace this with your real OpenWeather API key
  # construct the URL to get the API data (https://openweathermap.org/api/one-call-api)
  
  url = "https://api.openweathermap.org/data/2.5/onecall?lat=42.0574063&lon=-87.6722787&units=imperial&appid=512c72a4f3b368e1031146f0005347a7"

  # API Call
  @forecast = HTTParty.get(url).parsed_response.to_hash


  @todaystemp = ["Temperature: #{@forecast["current"]["temp"]} ° F", "Conditions: #{@forecast["current"]["weather"][0]["description"]}"]
  puts @todaystemp

  puts "Your Future 5 Day Forecast"
  extended = []
  day_number = 1
  for daily_forecast in @forecast ["daily"]
    extended << "The temperature is #{daily_forecast["temp"]["day"]} degrees and #{daily_forecast["weather"] [0] ["main"]}"
    day_number = day_number + 1
    end
    @finalforecast = extended [0, 5]

#GET NEWS
 newskey = "3d712c7a125448c594a43483fa7618e6"
  url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=#{newskey}"
  @news = HTTParty.get(url).parsed_response.to_hash

    stories = []
    article_number = 1
    for article in @news["articles"]
        stories << "#{article["url"]}>#{article_number}: #{article["title"]}"
        article_number = article_number + 1
    end

    @newspaper = stories[0,3]

    view 'news'
end


