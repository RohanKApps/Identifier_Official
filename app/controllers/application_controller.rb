require 'open-uri'
require 'json'

class ApplicationController < ActionController::Base
  def prompt
    render 'landing'
  end
  
  def login
    cookies['zipcode'] = params['zipcode']
    url = "https://www.zipcodeapi.com/rest/a8CJ8BbEtjY3ITW9iWX6L0hfRxIABH3LPGvYhHCK0AOJuKTMGRSrRaHIIpjj6m5V/radius.json/" + cookies['zipcode'] + "/5/mile"
    result = open(url).read
    @parsed_result = JSON.parse(result)
    redirect_to '/home'
  end
  
  def home
    render 'home'
  end
  
  def local
    url = "https://www.zipcodeapi.com/rest/a8CJ8BbEtjY3ITW9iWX6L0hfRxIABH3LPGvYhHCK0AOJuKTMGRSrRaHIIpjj6m5V/radius.json/" + cookies['zipcode'] + "/5/mile"
    result = open(url).read
    @parsed_result = JSON.parse(result)
    render 'local'
  end
  
  def submit
    @g = Disease.new
    @g.cold = nil;
    @g.fever = nil;
    @g.flu = nil;
    @g.strepthroat = nil;
    
    #Cold
    if (params[:cough] == 1) && (params[:congestion] == 1) && (params[:runny_nose] == 1)
      @g.cold = 3
    end
    
    if (params[:cough] == 1) && (params[:congestion] == 1)
      @g.cold = 2
    end
    
    if (params[:cough] == 1)
      @g.cold = 1
    end
    
    if (params[:congestion] == 1)
      @g.cold = 1
    end
    
    #Fever
    if (params[:headache] == 1) && (params[:fatigue] == 1) && (params[:cough] == 1) && (params[:warm_temp] == 1)
      @g.fever = 3
    end
    
    if (params[:headache] == 1) && (params[:fatigue] == 1) && (params[:warm_temp] == 1)
      @g.fever = 3
    end
    
    if (params[:fatigue] == 1) && (params[:cough] == 1) && (params[:warm_temp] == 1)
      @g.fever = 3
    end
    
    if (params[:headache] == 1) && (params[:cough] == 1) && (params[:warm_temp] == 1)
      @g.fever = 3
    end
    
    if (params[:headache] == 1) && (params[:fatigue] == 1)
      @g.fever = 2
    end
    
    if (params[:headache] == 1) && (params[:warm_temp] == 1)
      @g.fever = 2
    end
    
    if (params[:warm_temp] == 1) && (params[:fatigue] == 1)
      @g.fever = 2
    end
    
    if (params[:headache] == 1)
      @g.fever = 1
    end
    
    if (params[:warm_temp] == 1)
      @g.fever = 1
    end
    
    #Flu
    if (params[:cough] == 1) && (params[:headache] == 1) && (params[:fatigue] == 1) && (params[:congestion] == 1) && (params[:muscle_pain] == 1)
      @g.flu = 3
    end
    
    if (params[:fatigue] == 1) && (params[:congestion] == 1) && (params[:muscle_pain] == 1)
      @g.flu = 3
    end
    
    if (params[:cough] == 1) && (params[:headache] == 1) && (params[:muscle_pain] == 1)
      @g.flu = 3
    end
    
    if (params[:cough] == 1) && (params[:headache] == 1) && (params[:fatigue] == 1) && (params[:muscle_pain] == 1)
      @g.flu = 3
    end
    
    if (params[:cough] == 1) &&  (params[:congestion] == 1) && (params[:muscle_pain] == 1)
      @g.flu = 2
    end
    
    if (params[:cough] == 1) && (params[:headache] == 1) && (params[:muscle_pain] == 1)
      @g.flu = 2
    end
    
    if (params[:nausea] == 1)
      @g.flu = 2
    end
    
    if (params[:muscle_pain] == 1)
      @g.flu = 1
    end
    
    #Strep Throat
    if (params[:headache] == 1) && (params[:warm_temp] == 1) && (params[:sore_throat] == 1)
      @g.strepthroat = 3
    end
    
    if (params[:headache] == 1) && (params[:sore_throat] == 1)
      @g.strepthroat = 3
    end
    
    if (params[:sore_throat] == 1)
      @g.strepthroat = 2
    end
    
    ##Conclusion
    @r = Rank.new
    
    #Cold
    if @g.cold == 3
      @r.oneplace = "Cold"
    end
    if @g.cold == 2
      @r.twoplace = "Cold"
    end
    if @g.cold == 1
      @r.threeplace = "Cold"
    end
    
    #Fever
    if @g.fever == 3
      @r.oneplace = "fever"
    end
    if @g.fever == 2
      @r.twoplace = "fever"
    end
    if @g.fever == 1
      @r.threeplace = "fever"
    end
    
    #Flu
    if @g.flu == 3
      @r.oneplace = "Flu"
    end
    if @g.flu == 2
      @r.twoplace = "Flu"
    end
    if @g.flu == 1
      @r.threeplace = "Flu"
    end
    
    #Strepthroat
    if @g.strepthroat == 3
      @r.oneplace = "Strepthroat"
    end
    if @g.strepthroat == 2
      @r.twoplace = "Strepthroat"
    end
    if @g.strepthroat == 1
      @r.threeplace = "Strepthroat"
    end
    @r.save
    @g.save
    
    redirect_to "/predict"
  end
  
  def predict
    render 'show'
  end
  
  protect_from_forgery with: :exception
end
