# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :set_todo_item, only: [:edit_todo_item]
  skip_before_action :verify_authenticity_token, :only => [:create_todo_item]

  def landing
    @todos = Todo.all.order(:id)
  end

  def create_todo_item
    @todo_item = Todo.new(todo_item_params)
    if @todo_item.save
      render json: {message: "#{@todo} created"}
    else
      render json: {errors: @todo_item.errors}, status: :unprocessable_entity
    end
  end

  def edit_todo_item
    @todo_item.update(todo_item_params)
  end

  def reset_todo_items
    Todo.update_all(checked: false)
  end

  private

  def todo_item_params
    params.permit(:id, :title, :checked)
  end

  def set_todo_item
    @todo_item = Todo.find(todo_item_params[:id])
  end
end
