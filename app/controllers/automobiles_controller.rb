class AutomobilesController < ApplicationController
  respond_to :json

  def index
    automobiles = @database["automobiles"].query.all.map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    render :json => { automobiles: automobiles }
  end

  def show
    automobiles = @database["automobiles"].query.by_example({ _key: params[:id] }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    if automobiles.empty?
      head :not_found
    else
      render :json => { automobile: automobiles.first }
    end
  end

  def update
    id = params[:id]
    
    automobile, status = begin
        [ @database["automobiles"].query.first_example({ _key: id }).first, :ok ]
      rescue
        [ @database["automobiles"].create_document({_key: id}), :created ]
      end
    
    automobile["stock_number"] = params[:automobile][:stock_number]
    automobile["year"] = params[:automobile][:year]
    automobile["make"] = params[:automobile][:make]
    automobile["model"] = params[:automobile][:model]
    automobile["color"] = params[:automobile][:color]
    automobile["style"] = params[:automobile][:style].downcase if styles.include?( params[:automobile][:style].downcase )
    automobile["price"] = params[:automobile][:price]
    automobile["status"] = params[:automobile][:status].downcase if statuses.include?( params[:automobile][:status].downcase )

    automobile["doors"] = params[:automobile][:doors] if params[:automobile][:doors]
    automobile["displacement"] = params[:automobile][:displacement] if params[:automobile][:displacement]
    automobile["cylinders"] = params[:automobile][:cylinders] if params[:automobile][:cylinders]
    automobile["mileage"] = params[:automobile][:mileage] if params[:automobile][:mileage]

    automobile["carfax"] = params[:automobile][:carfax] if params[:automobile][:carfax]
    automobile["low_miles"] = params[:automobile][:low_miles] if params[:automobile][:low_miles]
    automobile["fully_serviced"] = params[:automobile][:fully_serviced] if params[:automobile][:fully_serviced]
    automobile["tilt_steering"] = params[:automobile][:tilt_steering] if params[:automobile][:tilt_steering]
    automobile["telescoping_steering"] = params[:automobile][:telescoping_steering] if params[:automobile][:telescoping_steering]
    automobile["power_steering"] = params[:automobile][:power_steering] if params[:automobile][:power_steering]
    automobile["power_windows"] = params[:automobile][:power_windows] if params[:automobile][:power_windows]
    automobile["power_locks"] = params[:automobile][:power_locks] if params[:automobile][:power_locks]
    automobile["power_mirrors"] = params[:automobile][:power_mirrors] if params[:automobile][:power_mirrors]
    automobile["power_brakes"] = params[:automobile][:power_brakes] if params[:automobile][:power_brakes]
    automobile["antilock_brakes"] = params[:automobile][:antilock_brakes] if params[:automobile][:antilock_brakes]
    automobile["all_wheel_drive"] = params[:automobile][:all_wheel_drive] if params[:automobile][:all_wheel_drive]
    automobile["alloy_wheels"] = params[:automobile][:alloy_wheels] if params[:automobile][:alloy_wheels]
    automobile["automatic"] = params[:automobile][:automatic] if params[:automobile][:automatic]
    automobile["cruise_control"] = params[:automobile][:cruise_control] if params[:automobile][:cruise_control]
    automobile["air_conditioning"] = params[:automobile][:air_conditioning] if params[:automobile][:air_conditioning]
    automobile["auto_climate_control"] = params[:automobile][:auto_climate_control] if params[:automobile][:auto_climate_control]
    automobile["dual_zone"] = params[:automobile][:dual_zone] if params[:automobile][:dual_zone]
    automobile["am"] = params[:automobile][:am] if params[:automobile][:am]
    automobile["fm"] = params[:automobile][:fm] if params[:automobile][:fm]
    automobile["cd"] = params[:automobile][:cd] if params[:automobile][:cd]
    automobile["mp3"] = params[:automobile][:mp3] if params[:automobile][:mp3]
    automobile["leather"] = params[:automobile][:leather] if params[:automobile][:leather]
    automobile["heated_seats_front"] = params[:automobile][:heated_seats_front] if params[:automobile][:heated_seats_front]
    automobile["heated_seats_rear"] = params[:automobile][:heated_seats_rear] if params[:automobile][:heated_seats_rear]
    automobile["roof_rack"] = params[:automobile][:roof_rack] if params[:automobile][:roof_rack]
    automobile["running_boards"] = params[:automobile][:running_boards] if params[:automobile][:running_boards]
    automobile["tow_package"] = params[:automobile][:tow_package] if params[:automobile][:tow_package]
    automobile["recent_brakes"] = params[:automobile][:recent_brakes] if params[:automobile][:recent_brakes]
    automobile["recent_tires"] = params[:automobile][:recent_tires] if params[:automobile][:recent_tires]
    automobile["recent_paint"] = params[:automobile][:recent_paint] if params[:automobile][:recent_paint]
    automobile["recent_timing_belt"] = params[:automobile][:recent_timing_belt] if params[:automobile][:recent_timing_belt]

    automobile["special_features"] = params[:automobile][:special_features] if params[:automobile][:special_features]
    automobile["nice_to_have"] = params[:automobile][:nice_to_have] if params[:automobile][:nice_to_have]
    automobile["extras"] = params[:automobile][:extras] if params[:automobile][:extras]
    
    resp = automobile.save
    
    if resp["error"]
      render :json => resp["error"], status: :unprocessable_entity
    else
      automobiles = @database["automobiles"].query.by_example({ _key: id }).map do |x|
        {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
      end
      
      render :json => { automobiles: automobiles }, :status => status
    end
  end

  def destroy
    begin
      automobiles = @database["automobiles"].query.first_example({ _key: params[:id] }).each do |automobile|
        automobile.delete
      end
      
      head :no_content
    rescue
      head :not_found
    end
  end

  
  def styles
    [
      "sedan",
      "sports car",
      "hatchback",
      "sports utility vehicle",
      "minivan",
      "microcar",
      "station wagon",
      "van",
      "recreational vehicle",
      "limousine",
      "other"
    ]
  end
  
  def statuses
    ['available', 'pending', 'sold']
  end
  
  def min_price
    1000
  end
  
  def max_price
    100_000
  end
  
  def first_year
    1920
  end
  
  def next_year
    Date.today.year + 1
  end
end
