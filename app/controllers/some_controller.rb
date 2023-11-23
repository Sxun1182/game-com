class SomeController < ApplicationController
  before_action :redirect_if_guest, except: [:index]

  # ...

  private

  def redirect_if_guest
    if guest_user?
      redirect_to new_user_registration_path, notice: '会員登録をしてください。'
    end
  end
  
  
end
