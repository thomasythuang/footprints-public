class ChatMessagesController < ApplicationController

  def show
    unless matched_fighter_ids.include?(params[:fighter_id].to_i)
      redirect_to '/'
    end

    @messages = messages_in_conversation
    @fighter = ::User.find(params[:fighter_id])
    @live_chat_enabled = ::Setting.find_by_name('live_chat').value
  end

  def create
    ChatMessage.create!(
      sender_id:    current_user.id,
      recipient_id: params[:fighter_id],
      message:      params[:message]
    )

    redirect_to chat_path(fighter_id: params[:fighter_id])
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
end
