jQuery(document).on "turbolinks:load", ->
  App.users_online = App.cable.subscriptions.create "PresenceChannel",
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      # Called when there's incoming data on the websocket for this channel
