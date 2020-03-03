# frozen_string_literal: true

module ApplicationHelper
  def order_articles_options
    [['Sort by', nil],
     ['Sort by Title', 'sort_by_title'],
     ['Sort by Description', 'sort_by_description_length'],
     ['Sort by User email', 'sort_by_users_email']]
  end

  def users_for_articles(user_ids=[])
    User.where.not(id: user_ids).pluck(:nickname, :id).map do |o|
      o << { 'disabled-option' => true } if o.second == current_user.id
      o
    end
  end

  def user_setting
    @user_setting ||= current_user&.setting || Setting.new
  end
end
