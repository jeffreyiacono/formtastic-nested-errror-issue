class ConversationsController < ApplicationController
  respond_to :html

  def new
    @conversation = Conversation.new
    @message      = @conversation.messages.build
  end

  def create
    @conversation = Conversation.new(params[:conversation])
    if @conversation.save
      redirect_to root_path, notice: 'conversation created!'
    else
      flash.now[:alert] = "Conversation not created. Errors: #{@conversation.errors.inspect}"
      render :new
    end
  end
end
