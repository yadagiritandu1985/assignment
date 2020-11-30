class AppointmentSearchService
  
  def initialize(params, current_user=nil)
    @params = params
    @q = params[:q]
    @doctor_id = params[:doctor_id]
    @current_user = current_user
  end
  
  def results
    case @q
     when 'all'
       all
     when 'today'
       todays
     when 'week'
       this_weeks
     when 'date' #specific date (DD/MM/YYYY) ex: '29/11/2020'
       specfic_to_date
     when 'my'
       users
     else
       all
    end
  end
  
  def users
    @current_user.appointments
  end
  
  def todays
    scope
    .joins(doctor_time_slot: :time_slot)
    .where(time_slots: { date: today })
  end

  def all
    scope.all
  end
  
  def this_weeks
    scope
    .joins(doctor_time_slot: :time_slot)
    .where(time_slots: { date: today.beginning_of_week..today.end_of_week })
  end
  
  def specfic_to_date
    return [] unless @params[:day]
    
    scope
    .joins(doctor_time_slot: :time_slot)
    .where(time_slots: { date: parse_date(@params[:day]) })
  end
  
  
  private
  
  def today
    Date.today
  end
  
  # should be in 'DD/MM/YYYY' format
  def parse_date(date)
    date.to_date
  rescue
    Date.strptime(date, '%m/%d/%Y') rescue nil
  end
  
  def scope
    Appointment
  end

end
