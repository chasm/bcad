class TelephonesController < ApplicationController
  respond_to :json
  
  before_filter :get_applicant_id

  def index
    telephones = @database["telephones"].query.by_example({ applicant_id: @applicant_id }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    render :json => { telephones: telephones }
  end

  def show
    telephones = @database["telephones"].query.by_example({ applicant_id: @applicant_id, _key: params[:id] }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    if telephones.empty?
      head :not_found
    else
      render :json => { telephones: telephones }
    end
  end

  def update
    id = params[:id]
    
    telephone, status = begin
        [ @database["telephones"].query.first_example({ applicant_id: @applicant_id, _key: id }).first, :ok ]
      rescue
        begin
          [ @database["telephones"].create_document({ _key: id }), :created ]
        rescue Exception => e 
          puts e
        end
      end
    
    telephone["applicant_id"] = @applicant_id
    telephone["digits"]  = params[:telephone][:digits] || telephone["digits"]
    telephone["usage"]   = params[:telephone][:usage]  || telephone["usage"]
    
    resp = telephone.save
    
    if resp["error"]
      render :json => resp["error"], status: :unprocessable_entity
    else
      telephones = @database["telephones"].query.by_example({ applicant_id: @applicant_id, _key: id }).map do |x|
        {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
      end
      
      render :json => { telephones: telephones }, :status => status
    end
  end

  def destroy
    begin
      @database["telephones"].query.first_example({ applicant_id: @applicant_id, _key: params[:id] }).each do |telephone|
        telephone.delete
      end
      
      head :no_content
    rescue
      head :not_found
    end
  end
  
  private
  
  def get_applicant_id
    @applicant_id = params[:applicant_id]
    
    head :unprocessable_entity unless @applicant_id
  end
end
