class FriendRequestsController < ApplicationController
  before_action :set_friend_request, only: [:show, :edit, :update, :destroy]

  # GET /friend_requests
  # GET /friend_requests.json
  def index
    # byebug
    if params[:requester] == "sent"
      @friend_requests = current_user.friend_requests_as_requester
    else
      @friend_requests = current_user.friend_requests_as_requested
    end
    filter_friend_requests
  end

  # GET /friend_requests/1
  # GET /friend_requests/1.json
  def show
  end

  # GET /friend_requests/new
  def new
    @friend_request = FriendRequest.new
  end

  # GET /friend_requests/1/edit
  def edit
  end

  # POST /friend_requests
  # POST /friend_requests.json
  def create
    @friend_request = current_user.friend_requests_as_requester.build(create_friend_request_params)

    respond_to do |format|
      if @friend_request.save
        format.html { redirect_to @friend_request, notice: 'Friend request was successfully created.' }
        format.json { render :show, status: :created, location: @friend_request }
      else
        format.html { render :new }
        format.json { render json: @friend_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friend_requests/1
  # PATCH/PUT /friend_requests/1.json
  def update
    respond_to do |format|
      if @friend_request.update(update_friend_request_params)
        format.html { redirect_to friends_path, notice: 'Friend request was successfully updated.' }
        format.json { render :show, status: :ok, location: @friend_request }
      else
        format.html { render :edit }
        format.json { render json: @friend_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friend_requests/1
  # DELETE /friend_requests/1.json
  def destroy
    @friend_request.destroy
    respond_to do |format|
      format.html { redirect_to friend_requests_url, notice: 'Friend request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend_request
      @friend_request = FriendRequest.find(params[:id])
    end

    def filter_friend_requests
      if params[:status] == 'accepted' 
        @friend_requests = @friend_requests.accepted
      elsif params[:status] == 'pending' 
        @friend_requests = @friend_requests.pending 
      end
    end

    # Only allow a list of trusted parameters through.
    def create_friend_request_params
      params.require(:friend_request).permit(:requested_id, :accepted)
    end

    def update_friend_request_params
      params.require(:friend_request).permit(:accepted)
    end
end
