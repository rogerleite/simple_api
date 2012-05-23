require 'rubygems'
require 'bundler/setup'
require 'sinatra/base'
require 'rabl'

Rabl.register!
Rabl.configure do |config|
  config.include_json_root = false
end

class Resource
  @@counter = 0
  attr_accessor :id, :name

  def initialize(attrs = {})
    @@counter += 1
    self.id = @@counter
    self.name = attrs[:name]
  end

  def self.all
    @@all ||= [Resource.new(:name => "Test1"), Resource.new(:name => "Test2")]
  end

  def self.find_by_id(id)
    param_id = id.to_i
    @resource = self.all.detect { |r| r.id == param_id }
  end
end

class SimpleApi < Sinatra::Base

  before do
    puts "=== Request Headers: #{request_headers.inspect}"
    puts "=== Request Cookies: #{request.cookies.inspect}" unless request.cookies.empty?
    puts "\n"

    response["Content-Type"] = "application/json"
  end

  helpers do

    # Source: https://gist.github.com/338809
    def request_headers
      env.inject({}){|acc, (k,v)| acc[$1.downcase] = v if k =~ /^http_(.*)/i; acc}
    end

  end

  get '/recursos/busca' do
    @resources = Resource.all
    render :rabl, :'resources/search', :format => "json"
  end

  get '/recursos/id/:id' do
    @resource = Resource.find_by_id(params[:id])
    if @resource.nil?
      status(404)
    else
      render :rabl, :'resources/show', :format => "json"
    end
  end

end
