class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters,if: :devise_controller?

	def customers
		if customer_signed_in?
		redirect_to my_page_path
		else
		redirect_to root_path
		end
	end
	
	def after_sign_in_path_for(resource)#サインイン後にどこに遷移するかを設定しているメソッド
	    root_path
	end
	
	def after_sign_out_path_for(resource)#サインアウト後にどこに遷移するかを設定しているメソッド
	    root_path
	end
	protected #呼び出された他のコントローラからも参照することができる
	def configure_permitted_parameters
			#ユーザー登録(sign_up)の際に、先ほど許可を外したemailのデータ操作を許可
	    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name,:first_name,:last_name_kana,:first_name_kana,:email ,:postal_code,:address,:phone_number])
	end

end
