class MapsController < ApplicationController

  def show

    @year_weather = YearWeather.where(:year => params[:year])[0]

    respond_to do |format|
      format.html
      format.json { render json: @year_weather.attributes }
    end

  end

  def about
    
  end

end