Rails.application.routes.draw do
  root 'welcome#show'
  resource :command, only: :create
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
end
