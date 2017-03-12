class SessionsController < ApplicationController
  def create
    opentok = OpenTok::OpenTok.new ENV['OPENTOK_API_KEY'], ENV['OPENTOK_SECRET_KEY']
    room = Room.find_by_name(params[:roomName])
    if room
      session_id = room.session_id
    else
      session = opentok.create_session
      session_id = session.session_id
      Room.create(name: params[:roomName], session_id: session_id)
    end
    token = opentok.generate_token session_id
    render json: {session_id: session_id, token: token}
  end
end
