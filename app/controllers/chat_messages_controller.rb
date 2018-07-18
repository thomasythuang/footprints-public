class ChatMessagesController < ApplicationController

  def show
    unless matched_fighter_ids.include?(params[:fighter_id].to_i)
      redirect_to '/'
    end

    @messages = messages_in_conversation
    @fighter = ::User.find(params[:fighter_id])
    @live_chat_enabled = live_chat_enabled
  end

  def create
    chat_message = ChatMessage.create!(
      sender_id:    current_user.id,
      recipient_id: params[:fighter_id],
      message:      params[:message]
    )

    if live_chat_enabled
      render json: {
        sender_id: chat_message.sender_id,
        recipient_id: chat_message.recipient_id,
        message: chat_message.message,
        created_at: chat_message.created_at.strftime("%a %b %e, %l:%M %p")
      }
    else
      redirect_to chat_path(fighter_id: params[:fighter_id])
    end
  end

  private

  def messages_in_conversation
    ChatMessage.where(
      '(sender_id = :sender_id AND recipient_id = :recipient_id) OR
        (sender_id = :recipient_id AND recipient_id = :sender_id)',
      { sender_id: current_user.id, recipient_id: params[:fighter_id] }
    )
  end

  def matched_fighter_ids
    Challenge.where(user_id: current_user.id, challenged: true)
      .select { |challenge| challenge.reverse_challenge.try(:challenged) }
      .map(&:target_user_id)
  end

  def live_chat_enabled
    ::Setting.find_by_name('live_chat').value
  end
end
