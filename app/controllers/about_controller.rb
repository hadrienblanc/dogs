class AboutController < ApplicationController
  def index
    @ruby_version = RUBY_VERSION
    @rails_version = Rails.version
    @environment = Rails.env
    @database = ActiveRecord::Base.connection.adapter_name
    @time = Time.zone.now
  end
end
