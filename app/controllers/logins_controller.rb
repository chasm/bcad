class LoginsController < ApplicationController
  respond_to :json
  
  before_filter :get_user_id
  
  def index
    out = @database["logins"].query.by_example({ user_id: @user_id }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    render :json => out
  end

  def show
    out = @database["logins"].query.first_example({ user_id: @user_id, _key: params[:id] }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    if out.empty?
      head :not_found
    else
      render :json => out
    end
  end

  def destroy
    begin
      users = @database["users"].query.first_example({ user_id: @user_id, _key: params[:id] }).each do |user|
        user.delete
      end
      
      head :no_content
    rescue
      head :not_found
    end
  end
  
  private
  
  def get_user_id
    @user_id = params[:user_id]
    
    head :unprocessable_entity unless @user_id
  end
end
