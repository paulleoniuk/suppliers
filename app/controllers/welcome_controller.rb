class WelcomeController < ApplicationController
  def index
    @customers = Customer.all
  end

  def registration
    @customer = Customer.new
  end

  def sign_in
    customer = set_customer
    if customer.present?
      redirect_to customer_booking_path(customer: @customer), 
                                       notice: 'Customer is already registered.'
    else
      @customer = Customer.new(customer_params)

      respond_to do |format|
        if @customer.save
          format.html { redirect_to customer_booking_path(customer: @customer),
                                                         notice: 'Customer was successfully created.' }
          format.json { render :show, status: :created, location: @customer }
        else
          format.html { render :registration }
          format.json { render json: @customer.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def booking
    @booking = Booking.new
    @customer = Customer.find(params[:customer])
  end

  def result
    date = get_date(params)
    city = City.find_by(id: params[:booking][:city_id])
    city_cleaners_ids = CityCleaner.where(city_id: city.id).pluck(:cleaner_id)
    city_unavailable_cleaner_ids = Booking.where(city_id: city.id).where(date: date).pluck(:cleaner_id)
    city_free_cleaners = Cleaner.where(id: city_cleaners_ids).where.not(id: [city_unavailable_cleaner_ids])
    puts city_free_cleaners.pluck(:id)
    if city_free_cleaners.any?
        @booking = Booking.new(city_id: city.id,
                               customer_id: params[:customer_id],
                               cleaner_id: city_free_cleaners.first.id,
                               date: date)
    end

    respond_to do |format|
      if city_free_cleaners&.any? && @booking.save
        format.html { redirect_to root_path, notice: "Booking was successfully created.
          Your cleaner: #{city_free_cleaners.first.first_name} #{city_free_cleaners.first.last_name}" }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { redirect_to root_path, notice: "ids: #{city_free_cleaners.pluck(:id)}Could not fulfill your request" }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end
 

  private

  def get_date(params)
    DateTime.new(params['booking']["date(1i)"].to_i, 
                        params['booking']["date(2i)"].to_i,
                        params['booking']["date(3i)"].to_i,
                        params['booking']["date(4i)"].to_i,
                        params['booking']["date(5i)"].to_i)
  end
    # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = Customer.find_by(phone_number: params[:customer][:phone_number])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :phone_number)
  end
end
