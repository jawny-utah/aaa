# frozen_string_literal: true

class HelloWorldController < ApplicationController
  layout "hello_world"

  def index
    @hello_world_props = { name: current_user&.nickname || "Stranger" }
  end
end
