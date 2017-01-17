require 'sinatra'
require 's3'
require 'dotenv/load'

S3_ACCESS_KEY  = ENV['S3_ACCESS_KEY_ID']
S3_SECRET      = ENV['S3_SECRET_ACCESS_KEY']
S3_BUCKET      = ENV['S3_BUCKET']

s3 = S3::Service.new(:access_key_id => S3_ACCESS_KEY, :secret_access_key => S3_SECRET)

get "/" do
  html = []
  html << %{<h1>#{S3_BUCKET}</h1>}
  html << %{<ul>}
  s3.buckets.find(S3_BUCKET).objects.each do |object|
    html << %{<li><a href="#{object.temporary_url}">#{object.full_key}</a></li>}
  end
  html << %{</ul>}
  html
end
