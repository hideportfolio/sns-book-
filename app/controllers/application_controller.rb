# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # デバイス機能実行前にconfigure_permitted_parametersの実行をする。
  protect_from_forgery with: :exception
  before_action :set_host

  protected

  def set_host
    Rails.application.routes.default_url_options[:host] = request.host_with_port
  end

  def after_sign_in_path_for(resource)
    NotificationMailer.send_confirm_to_user(resource).deliver
    user_path(resource)
  end

  # sign_out後のredirect先変更する。rootパスへ。rootパスはhome topを設定済み。
  def after_sign_up_path_for(resource)
    NotificationMailer.send_confirm_to_user(resource).deliver
    user_path(resource)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email postcode prefecture_name address_city address_street address_building])
    # sign_upの際にnameのデータ操作を許。追加したカラム。
  end

  def search
    # Viewのformで取得したパラメータをモデルに渡す
    @posts = Post.search(params[:search])
  end
end
