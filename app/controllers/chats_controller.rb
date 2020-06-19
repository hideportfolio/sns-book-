# frozen_string_literal: true

class ChatsController < ApplicationController
  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    if user_rooms.nil?
      @room = Room.new
      @room.save
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    else
      @room = user_rooms.room
      @chats = @room.chats
    end
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save
    room = @chat.room
    @chats = room.chats
  end

  #   def show
  #     @user = User.find(params[:id])

  #     if Room.find_by(talk_user_1: @user, talk_user_2: current_user).present?
  #       room = Room.find_by(talk_user_1: @user, talk_user_2: current_user)
  #       @chats = room.chats
  #       @chat = Chat.new
  #     elsif Room.find_by(talk_user_2: @user, talk_user_1: current_user).present?
  #       room = Room.find_by(talk_user_2: @user, talk_user_1: current_user)
  #       @chats = room.chats
  #       @chat = Chat.new
  #     else
  #       room = Room.new
  #       room.talk_user_1 = current_user
  #       room.talk_user_2 = @user
  #       room.save
  #       @chats = room.chats
  #       @chat = Chat.new
  #     end
  #   end

  #   def create
  #     @user = User.find(params[:id])
  #     if Room.find_by(talk_user_1: @user, talk_user_2: current_user).present?
  #       room = Room.find_by(talk_user_1: @user, talk_user_2: current_user)
  #       @chat = Chat.new(chat_params)
  #       @chat.room_id = room.id
  #       @chat.is_speak = false
  #     elsif Room.find_by(talk_user_2: @user, talk_user_1: current_user).present?
  #       room = Room.find_by(talk_user_2: @user, talk_user_1: current_user)
  #       @chat = Chat.new(chat_params)
  #       @chat.room_id = room.id
  #       @chat.is_speak = true
  #       end
  #     @chat.save
  #     byebug
  #     redirect_to request.referer
  #   end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
end
