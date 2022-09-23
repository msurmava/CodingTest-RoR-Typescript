# frozen_string_literal: true
require 'prawn-styled-text'

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

  def pdf
    @todos = Todo.all.order(:id)
    pdf = Prawn::Document.new
  
    pdf.styled_text "<h1 style='text-align: center; font-size: 20px'>YOUR TODO LIST</h1>"
    pdf.styled_text "<br>"

    @todos.each do |todo|
      if todo.checked?
       pdf.styled_text "<s font-size: 20px; margin-top: 20;'> - #{todo.title}</s>"
      else
       pdf.styled_text "<p font-size: 20px; margin-top: 20;'> - #{todo.title}</p>"
      end
      pdf.styled_text "<hr> </hr>"

    end
  
    send_data(pdf.render,
      filename: "todo.pdf",
      type: "application/pdf",
      disposition: "inline"
    )  
   
  end
 

  private

  def todo_item_params
    params.permit(:id, :title, :checked)
  end

  def set_todo_item
    @todo_item = Todo.find(todo_item_params[:id])
  end
end
