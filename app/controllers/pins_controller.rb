class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @pins = Pin.all
  end

  def show
  end

  def new
    @pin = current_user.pins.build
  end

  def edit
  end

  def create
    @pin = current_user.pins.build(pin_params)
    if @pin.save
      redirect_to @pin, notice: 'Pin was successfully created.'
    else
      render :new
    end
  end

  def update
    if @pin.update(pin_params)
      format.html { redirect_to @pin, notice: 'Pin was successfully updated.' }
    else
      format.html { render :edit }
      format.json { render json: @pin.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    @pin.destroy
    format.html { redirect_to pins_url, notice: 'Pin was successfully destroyed.' } 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pin
      @pin = Pin.find(params[:id])
    end

    def correct_user
      if !user_signed_in? || current_user.pins.find(params[:id]).nil?
        redirect_to pins_path, notice: "Not authorized to edit this pin"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pin_params
      params.require(:pin).permit(:description)
    end
end
