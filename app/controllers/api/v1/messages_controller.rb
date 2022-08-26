module Api
  module V1
    class MessagesController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_message, only: [:show, :update, :destroy]

      # GET /messages
      def index
        @messages = current_user.messages

        render json: @messages
      end

      # GET /messages/1
      def show
        render json: @message
      end

      # POST /messages
      def create
        @message = current_user.messages.build(message_params)

        if @message.save
          render json: @message, status: :created, location: @message
        else
          render json: @message.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /messages/1
      def update
        if @message.update(message_params)
          render json: @message
        else
          render json: @message.errors, status: :unprocessable_entity
        end
      end

      # DELETE /messages/1
      def destroy
        @message.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_message
        @message = current_user.messages.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def message_params
        params.require(:message).permit(:conversation_id, :user_id, :content)
      end
    end
  end
end
