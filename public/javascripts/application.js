$(document).ready(function() {

  $('ul:first').click(function(event) {
    var myself = $(event.target);
    if (myself.is('a')) {
      if (myself.text().match(/cancel/i)) {
        myself.parents('li:first').load(myself.attr('href'));
        event.preventDefault();
      }
      if (myself.text().match(/discard/i)) {
        myself.parents('li:first').remove();
        event.preventDefault();
      }
      if (myself.text().match(/edit/i)) {
        myself.parents('div:first').load(myself.attr('href') + ' div:first');
        event.preventDefault();
      }
      if (myself.text().match(/new/i)) {
        $('<li></li>').appendTo(myself.prev()).load(myself.attr('href') +
          ' div:first');
        event.preventDefault();
      }
      if (myself.text().match(/destroy/i)) {
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

  $('ul:first + a').click(function(event) {
    $('<li></li>').appendTo('ul:first').load($(this).attr('href') +
      ' div:first');
    event.preventDefault();
  });

  $('#msgs').ajaxError(function(event, request, options, error) {
    $('#errorExplanation ul li', request.responseText)
      .wrapInner('<p></p>').find('p:first').css({ color: 'red' })
      .appendTo($(this)).fadeOut(2000, function() { $(this).remove(); });
  });

});
