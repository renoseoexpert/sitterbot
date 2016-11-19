class SubscriptionsController < ApplicationController
  before_action :require_login!
  layout 'auth'

  def new
    if current_consultant.trial?
      redirect_to '/'
      return
    end

    if params[:plan]
      current_consultant.selected_plan = params[:plan]
      current_consultant.save
    end
  end

  def create
    # Does the user have a subscription?
    # - if so see if it matches the planid that was passed
    service = StartSubscription.new(current_consultant, subscription_params)
    service.call
    if service.valid?
      login(service.consultant.user)
      UserMailer.new_subscription(service.consultant.user).deliver_later
      ActivateDripSubscriberJob.perform_later(service.consultant.user)
      redirect_to '/subscribed'
    else
      flash.now[:errors] = service.errors
      render :new
    end
  end

  def edit
  end

  def show
  end

  private

  def subscription_params
    params.require(:subscription).permit(
      :plan_id,
      :stripe_id,
      :credit_card_token,
      :card_type,
      :last_four
    )
  end
end
