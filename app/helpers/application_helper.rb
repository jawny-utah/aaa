# frozen_string_literal: true

module ApplicationHelper
  def human_order_articles
    { 'sort_by_title' => 'Title',
      'sort_by_description_length' => 'Description',
      'sort_by_users_email' => 'User Email' }
  end
end
