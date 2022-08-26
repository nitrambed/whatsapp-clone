module Api
  module V1
    class ContactsController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_contact, only: [:show, :update, :destroy]

      # GET /contacts
      def index
        @data = []
        @contacts = current_user.contacts
        @contacts.each do |contact|
          @data << {
            contact_firstname: contact.user_contact.user.first_name,
            contact_lastname: contact.user_contact.user.last_name,
          }
        end
        render json: @data
        render json: @data
      end

      # GET /contacts/1
      def show
        render json: @contact
      end

      # POST /contacts
      def create
        @contact = current_user.contacts.build(contact_params)

        if @contact.save
          render json: @contact, status: :created, location: @contact
        else
          render json: @contact.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /contacts/1
      def update
        if @contact.update(contact_params)
          render json: @contact
        else
          render json: @contact.errors, status: :unprocessable_entity
        end
      end

      # DELETE /contacts/1
      def destroy
        @contact.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_contact
        @contact = current_user.contacts.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def contact_params
        params.require(:contact).permit(:user_id, :user_contact_id)
      end
    end
  end
end
