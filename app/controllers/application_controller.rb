class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  # json でのリクエストの場合CSRFトークンの検証をスキップ
  skip_before_action :verify_authenticity_token,     if: -> {request.format.json?}
  # トークンによる認証
  before_action      :authenticate_user_from_token!, if: -> {params[:email].present?}

  # 権限無しのリソースにアクセスしようとした場合
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { render json: {message: exception.message}, status: :unauthorized }
    end
  end

  # トークンによる認証
  def authenticate_user_from_token!
    user = User.find_by(email: params[:email])
    if Devise.secure_compare(user.try(:authentication_token), params[:token])
      sign_in user, store: false
    end
  end
end
