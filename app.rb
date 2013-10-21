require 'sinatra'
require 'keen'

get "/" do
  <<-DOC
  <h1>Twine Keen Proxy</h1>
  <code>
  This is a proxy that listens for webhook calls from a Supermechanical Twine and posts them as events to Keen IO.
  <br>
  Point the twine to /event. Make sure to set COLLECTION_NAME, KEEN_PROJECT_ID and KEEN_WRITE_KEY on the environment.
  </code>
  DOC
end

get '/event' do
  unless collection_name = ENV["COLLECTION_NAME"]
    raise "Please set the Keen IO COLLECTION_NAME to use on the environment."
  end

  properties = params

  # return the response of a synchronous keen publishing call
  response = Keen.publish(collection_name, properties)
  response.to_json
end
