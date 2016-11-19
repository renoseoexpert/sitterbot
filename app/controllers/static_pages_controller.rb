class StaticPagesController < ApplicationController
  before_action :require_login!, only: [:root]
  before_action :require_subscription!, only: [:root]
  layout 'marketing'

  def root
    render layout: 'application'
  end

  def subscribed
    render layout: false
  end

  def welcome
  end

  def letsencrypt
    render text: SslVerification.find_by(key: params[:id]).try(:value)
  end
end
