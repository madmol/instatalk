jQuery(document).on "turbolinks:load", ->
  App.users_online = App.cable.subscriptions.create "UsersOnlineChannel",
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      # Called when there's incoming data on the websocket for this channel
      if data["info"]["online"] == false
        $("#user_id_#{data['info']['id']}").remove()
      else
        html =
        """
          <li id="user_id_#{data['info']['id']}" class="list-group-item">
            #{data['info']['nickname']}
          </li>
        """
        $(html).appendTo("#usersonline")
