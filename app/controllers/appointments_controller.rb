class AppointmentsController < ApplicationController

  # GET /api/v1/appointments/:q
  # q: 
  # my: to list current user appointments
  # all: to list all appointments (default)
  # today: to list today's all appointments
  # week: to list this week's  all appointments
  # date: to list specific date wise appointments (should pass 'day' param with specific date in DD/MM/YYYY format) 
  
  # Other params
  # day: specific date in DD/MM/YYYY format along with date query
  # doctor_id: doctor's list of appointments
  def index
    search = AppointmentSearchService.new(params, current_user)
    appointments = search.results
                  
    appointments = appointments.where(doctor_id: params[:doctor_id]) if params[:doctor_id] && !appointments.empty?   
                   
    render json: { appointments: map_json(appointments) }, status: :ok
  end

  # POST /api/v1/appointments
  # params: user_id, doctor_id, doctor_time_slot_id
  def create
    no_current_user and return unless current_user
    
    appointment = current_user.appointments.new(appointment_params)
    if appointment.save
      render json: { message: 'Appointment created successfully', id: appointment.id }, status: :created
    else
      render json: { errors: appointment.errors.full_messages }, status: :bad_request
    end
  end

  private
  
  def map_json(obj_or_collection)
    obj_or_collection.as_json(
      only: [:id, :created_at], 
      include: { 
        user: {
          only: [:id, :name, :email]
        },
        doctor_time_slot: {
          only: [],
          include: {
            doctor: { 
              only: [:id, :name]
            },
            time_slot: { 
              only: [:start_time, :end_time, :date, :duration]
            }
          }
        }
      }
    )
  end
  
  def no_current_user
    render json: { error: 'User not authorized!' }, status: :unauthorized
  end
  
  def appointment_params
    params.permit(:user_id, :doctor_id, :doctor_time_slot_id)
  end
end
