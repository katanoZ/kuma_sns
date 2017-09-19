jQuery(document).on 'turbolinks:load', ->

  talks = $('#talks')
  if $('#talks').length > 0
    App.chat = App.cable.subscriptions.create { channel: "ChatChannel", chat_id: talks.data('chat_id') },
      received: (data) ->
        $('#talks').append data['talk']

      speak: (talk) ->
        user_id = document.forms.id_talk_form.id_user.value
        chat_id = document.forms.id_talk_form.id_chat.value
        @perform 'speak', talk: talk, user_id: user_id, chat_id: chat_id

  $(document).off 'keypress'
  $(document).on 'keypress', '[data-behavior~=chat_speaker]', (event) ->
    if event.keyCode is 13 # return = send
      App.chat.speak event.target.value
      event.target.value = ''
      event.preventDefault()
