class PhotosController < ApplicationController
  respond_to :json
  
  before_filter :get_automobile_id

  def index
    photos = @database["photos"].query.by_example({ automobile_id: @automobile_id }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    render :json => { photos: photos }
  end

  def show
    photos = @database["photos"].query.by_example({ automobile_id: @automobile_id, _key: params[:id] }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    if photos.empty?
      head :not_found
    else
      render :json => { photos: photos }
    end
  end

  def update
    id = params[:id]
    
    photo, status = begin
        [ @database["photos"].query.first_example({ automobile_id: @automobile_id, _key: id }).first, :ok ]
      rescue
        begin
          [ @database["photos"].create_document({ _key: id }), :created ]
        rescue Exception => e 
          puts e
        end
      end
    
    photo["automobile_id"]  = @automobile_id
    photo["file_name"]      = params[:photo][:file_name]  || photo["file_name"]  

    resp = photo.save
    
    if resp["error"]
      render :json => resp["error"], status: :unprocessable_entity
    else
      photos = @database["photos"].query.by_example({ automobile_id: @automobile_id, _key: id }).map do |x|
        {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
      end
      
      render :json => { photos: photos }, :status => status
    end
  end

  def destroy
    begin
      @database["photos"].query.first_example({ automobile_id: @automobile_id, _key: params[:id] }).each do |photo|
        photo.delete
      end
      
      head :no_content
    rescue
      head :not_found
    end
  end
  
  private
  
  def get_automobile_id
    @automobile_id = params[:automobile_id]
    
    head :unprocessable_entity unless @automobile_id
  end
end
