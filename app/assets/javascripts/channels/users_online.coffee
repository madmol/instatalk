jQuery(document).on "turbolinks:load", ->
  App.users_online = App.cable.subscriptions.create "UsersOnlineChannel",
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      # Called when there's incoming data on the websocket for this channel
      { id, nickname, online } = data.user

      if online
        html = """
               <li id="user_id_#{id}" class="list-group-item">
                 #{nickname}
               </li>
               """
        $(html).appendTo("#usersonline")
      else
        $("#user_id_#{id}").remove()
