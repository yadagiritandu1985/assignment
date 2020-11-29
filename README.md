# README

ruby 2.5.8
rails 5.2.4.4
Mysql

# Rspec
bundle exec rspec spec

# Coverage
Go to coverage folder and open index.html file in browser to see test coverage.


# API Endpoints to test

#1: User Registeration
URL: http://localhost:3000/api/v1/auth/register
METHOD: POST
Params: name, email, password

#2: User Login
URL: http://localhost:3000/api/v1/auth/login
METHOD: POST
Params: email, password

#3: List Doctor TimeSlots
URL: http://localhost:3000/api/v1/time_slots/doctor_slots/6
METHOD: GET
Headers: Authorization: Bearer #{token value from login api}

#4: List Doctor Available TimeSlots Only
URL: http://localhost:3000/api/v1/time_slots/available_slots/6
METHOD: GET
Headers: Authorization: Bearer #{token value from login api}

#4: Create an Appointment
URL: http://localhost:3000/api/v1/appointments
METHOD: POST
Headers: Authorization: Bearer #{token value from login api}
Params: doctor_id, doctor_time_slot_id (will get time slot id from above time_slots api)

#4: List Appointments
URL: http://localhost:3000/api/v1/appointments
METHOD: GET
Headers: Authorization: Bearer #{token value from login api}
Query (q):
http://localhost:3000/api/v1/appointments  #for all appointments
http://localhost:3000/api/v1/appointments?q=my  # logged in user appointments only
http://localhost:3000/api/v1/appointments?q=today  # today's appointments only
http://localhost:3000/api/v1/appointments?q=week  # this week appointments only
http://localhost:3000/api/v1/appointments?q=date&day=29/11/2020  # specific day appointments
http://localhost:3000/api/v1/appointments?doctor_id=7 # specific doctor appointments only
