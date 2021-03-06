class RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end
  #
  # #PUT /resource
  # def update
  #       self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
  #       prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
  #       resource_updated = update_resource(resource, account_update_params)
  #       yield resource if block_given?
  #       if resource_updated
  #         respond_with resource, :location => after_sign_in_path_for(resource) do |format|
  #           format.json {render :json => resource }
  #         end
  #       end
  #     end
  #   end
  #

  def update
      if @user.update(user_params)
        render json: @user
      else
        render json: { error: t('user_update_error') }, status: :unprocessable_entity
      end
  end

  def destroy
    if @user.destroy
      head :no_content
    else
      render json: { error: t('user_delete_error') }, status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
