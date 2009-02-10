$(document).ready(function() {

  $('ul:first').click(function(event) {
    var myself = $(event.target);
    if (myself.is('a.control')) {
      if (myself.is('.cancel')) {
        myself.parents('li:first').load(myself.attr('href') + ' div:first');
        event.preventDefault();
      }
      if (myself.is('.discard')) {
        myself.parents('li:first').remove();
        event.preventDefault();
      }
      if (myself.is('.edit')) {
        myself.parents('li:first').find('div:first')
          .load(myself.attr('href') + ' div:first');
        event.preventDefault();
      }
      if (myself.is('.new')) {
        $('<li></li>').appendTo(myself.parents('li').find('ul:first'))
          .load(myself.attr('href') + ' div:first');
        event.preventDefault();
      }
      if (myself.is('.destroy')) {
        if (confirm('Are you sure?')) {
          $.ajax({
            type: 'POST',
            url: myself.attr('href'),
            data: "_method=delete&" +
                  encodeURIComponent(window._auth_token_name) + '=' +
                  encodeURIComponent(window._auth_token),
            success: function(msg) {
              myself.parents('li:first').fadeOut(200, function() {
                $(this).remove();
              });
            },
            error: function(req, msg, err) {
              alert('Error while deleting :' + msg);
            }
          });
        }
        event.preventDefault();
      }
    }
    if (myself.attr('type') &&  myself.attr('type').match(/submit/i)) {
      var myform = myself.parents('form');
      myself.parents('li:first').load(myform.attr('action') + ' div:first',
        myform.serializeArray());
      event.preventDefault();
    }
  });

  $('ul:first + a.control.new').click(function(event) {
    $('<li></li>').appendTo('ul:first')
      .load($(this).attr('href') + ' div:first');
    event.preventDefault();
  });

  $('#msgs').ajaxError(function(event, request, options, error) {
    $('#errorExplanation ul li', request.responseText)
      .wrapInner('<p></p>').find('p:first').css({ color: 'red' })
      .appendTo($(this)).fadeOut(2000, function() { $(this).remove(); });
  });

});
