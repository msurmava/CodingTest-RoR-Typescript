# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "home#landing"
  post "todo", to: "home#edit_todo_item"
  post "reset", to: "home#reset_todo_items"
  post "todos", to: "home#create_todo_item"
  get '/pdf', to: 'home#pdf'
end
