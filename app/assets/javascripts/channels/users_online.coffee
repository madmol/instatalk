jQuery(document).on 'turbolinks:load', ->
  App.users_online = App.cable.subscriptions.create "UsersOnlineChannel",
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
    	# Called when there's incoming data on the websocket for this channel
    	console.log(data['message']['user_offline']?)
    	if data['message']['user_offline']?
    		nickname = data['message']['user_offline']
    		$("#" + nickname + "").remove()
    	else
    		$('#usersonline').append data['message']