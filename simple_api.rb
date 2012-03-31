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
    response["Content-Type"] = "application/json"
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
