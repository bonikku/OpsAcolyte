class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!

  def landing_page
  end

  def privacy_policy
  end

  def calendar
    @tasks = Task.all
  end
end
