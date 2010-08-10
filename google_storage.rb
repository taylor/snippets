#!/usr/bin/env ruby

# Example of using gstore
# http://github.com/moomerman/gstore

require 'rubygems'
require 'gstore'
require 'yaml'

config=YAML.load_file('google_storage.yml')

client = GStore::Client.new(
   :access_key => config[:ACCESS_KEY],
   :secret_key => config[:SECRET_KEY]
)

bucket_name= 'test-' + rand.to_s
client.create_bucket(bucket_name)
client.get_bucket(bucket_name)

# List all of your existing Buckets
puts client.list_buckets

client.delete_bucket(bucket_name)
