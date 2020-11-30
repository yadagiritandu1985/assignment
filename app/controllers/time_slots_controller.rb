class TimeSlotsController < ApplicationController

  # GET /api/v1/time_slots/available_slots/:doctor_id 
  def available_slots
    doctor = Doctor.find(params[:doctor_id])
    available_slots = doctor.doctor_time_slots.where(is_available: true)
    render json: { time_slots: map_json(available_slots) }, status: 200
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'No Doctor Found!' }, status: 404
  end
  
  # GET /api/v1/time_slots/doctor_slots/:doctor_id  
  def doctor_slots
    doctor = Doctor.find(params[:doctor_id])
    render json: { time_slots: map_json(doctor.doctor_time_slots) }, status: 200
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'No Doctor Found!' }, status: 404
  end
  
  private
  
  def map_json(obj_or_collection)
    obj_or_collection.as_json(
      only: %i(id doctor_id is_available), 
      include: { 
        time_slot: { 
          only: [:start_time, :end_time, :date, :duration]
        } 
      }
    )
  end

end
