class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: %i[edit update destroy]
  before_action :set_or_create_room, only: %i[show]

  def index
    @rooms = Room.where(user: current_user).or(Room.where(product: current_user.store.products))
    @messages = nil
  end

  def show
    @rooms = Room.where(user: current_user).or(Room.where(product: current_user.product))
    @messages = @room.messages
    # @rooms = Room.all
    render 'index'
  end

  def new
    @room = Room.new
  end

  def edit
  end

  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        format.html { redirect_to @room, notice: "Room was successfully created." }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to @room, notice: "Room was successfully updated." }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: "Room was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  
  def set_room
    @room = Room.find(params[:id])
  end

  def set_or_create_room
    if params[:product].present?
      product = Product.find(params[:product])
      @room = Room.find_by(product: product, user: current_user)

      if @room.nil?
        @room = Room.create!(name: product.name, product: product, user: current_user)
      end
    else
      @room = Room.find_by(id: params[:id])
    end
  end

  def room_params
    params.require(:room).permit(:name)
  end
end
