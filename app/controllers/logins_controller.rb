class LoginsController < ApplicationController
  respond_to :json
  
  before_filter :get_applicant_id
  
  def index
    puts ">>>>> index params: "
    puts params
    
    logins = if params[:applicant_id]
      @database["logins"].query.by_example({ applicant_id: @applicant_id }).map do |x|
        {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
      end
    else
      @database["logins"].query.all.map do |x|
        {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
      end
    end
    
    render :json => { logins: logins }
  end

  def show
    puts ">>>>> show params: "
    puts params
    
    logins = if params[:applicant_id]
      @database["logins"].query.first_example({ applicant_id: @applicant_id, _key: params[:id] }).map do |x|
        {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
      end
    else
      @database["logins"].query.first_example({ _key: params[:id] }).map do |x|
        {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
      end
    end
    
    if logins.empty?
      head :not_found
    else
      render :json => { logins: logins }
    end
  end

  def destroy
    begin
      @database["logins"].query.first_example({ applicant_id: @applicant_id, _key: params[:id] }).each do |login|
        login.delete
      end
      
      head :no_content
    rescue
      head :not_found
    end
  end
  
  private
  
  def get_applicant_id
    @applicant_id = params[:applicant_id]
    
    # head :unprocessable_entity unless @applicant_id
  end
end
