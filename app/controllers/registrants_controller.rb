class RegistrantsController < ApplicationController
  respond_to :json

  def index
    registrants = @database["registrants"].query.all.map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    render :json => { registrants: registrants }
  end

  def show
    registrants = @database["registrants"].query.by_example({ _key: params[:id] }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    if registrants.empty?
      head :not_found
    else
      render :json => { registrants: registrants }
    end
  end

  def destroy
    begin
      registrants = @database["registrants"].query.first_example({ _key: params[:id] }).each do |registrant|
        registrant.delete
      end
      
      head :no_content
    rescue
      head :not_found
    end
  end
end
