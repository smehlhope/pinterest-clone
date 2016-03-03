class PinsController < ApplicationController
	before_action :find_pin, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :authenticate_user!, except: [:index, :show]

  def index
  	#reverse order of pins - newest at top
  	@pins = Pin.all.order("created_at DESC")
  end

  def show
  end

  def new
  	@pin = current_user.pins.build
  end

  def create
  	@pin = current_user.pins.build(pin_params)
  	if @pin.save
  		redirect_to @pin, notice: "Successfully created a new Pin"
  	else
  		render 'new'
  	end
  end

  def edit
  	#pin found in before_action
  end

  def update
  	if @pin.update(pin_params)
  		redirect_to @pin, notice: "Pin was successfully updated"
  	else
  		render 'edit'
  	end
  end

  def destroy
  	@pin.destroy
  	redirect_to root_path
  end

  def upvote
    #pin found by before_action
    @pin.upvote_by current_user
    redirect_to :back
  end

  private

  def pin_params
  	params.require(:pin).permit(:image, :title, :description)
  end

  def find_pin
  	@pin = Pin.find(params[:id])
  end

end
