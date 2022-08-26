module Api
  module V1
    class ConversationsController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_conversation, only: [:show, :update, :destroy]

      # GET /conversations
      def index
        @data = []
        @conversations = current_user.conversations
        @conversations.each do |conversation|
          @data << {
            user_contact_firstname: conversation.user_contact.user.first_name,
            user_contact_lastname: conversation.user_contact.user.last_name,
          }
        end
        render json: @data
      end

      # GET /conversations/1
      def show
        render json: @conversation
      end

      # POST /conversations
      def create
        @conversation = current_user.conversations.build(conversation_params)

        if @conversation.save
          render json: @conversation, status: :created, location: @conversation
        else
          render json: @conversation.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /conversations/1
      def update
        if @conversation.update(conversation_params)
          render json: @conversation
        else
          render json: @conversation.errors, status: :unprocessable_entity
        end
      end

      # DELETE /conversations/1
      def destroy
        @conversation.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_conversation
        @conversation = current_user.conversations.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def conversation_params
        params.require(:conversation).permit(:user_id, :user_contact_id)
      end
    end
  end
end
