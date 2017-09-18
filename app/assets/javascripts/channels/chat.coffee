App.chat = App.cable.subscriptions.create "ChatChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#talks').append data['talk']

  speak: (talk) ->
    user_id = document.forms.id_talk_form.id_user.value
    chat_id = document.forms.id_talk_form.id_chat.value
    @perform 'speak', talk: talk, user_id: user_id, chat_id: chat_id

$(document).on 'keypress', '[data-behavior~=chat_speaker]', (event) ->
  if event.keyCode is 13 # return = send
    App.chat.speak event.target.value
    event.target.value = ''
    event.preventDefault()
