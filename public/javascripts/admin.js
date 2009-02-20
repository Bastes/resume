$(document).ready(function() {

  // making the lists sortable
  $('#resume ul.items').sortable({
    handle: 'h2, h3, h4, h5, h6',
    opacity: 1,
    axis: 'y',
    update: function(event, ui) {
      items = ui.element.children(':not(:last)');
      var params = { _method: 'PUT' };
      params[window._auth_token_name] = window._auth_token;
      params['item[rank]'] = ui.item.prevAll().length + 1;
      $.post(ui.item.find('.control.show:first').attr('href'), params,
        function(data) {
          items.each(function(index) {
            $(this).removeClass().addClass('rank_' + (index + 1));
          });
        }
      );
    }
  });

  $('a#clear_cache').click(function(event) {
    event.preventDefault();
    if (confirm('Are you sure?')) {
      $.ajax({
        type: 'POST',
        url: $(this).attr('href'),
        data: "_method=delete&" +
          encodeURIComponent(window._auth_token_name) + '=' +
          encodeURIComponent(window._auth_token),
        success: function(msg) {
          $('<p></p>').addClass('notice').text(msg).prependTo("#msgs")
            .fadeOut(2000, function() { $(this).remove(); });
        }
      });
    }
  });

  $('#resume ul.items').click(function(event) {
    var myself = $(event.target);
    if (myself.is('a.control')) {
      // responding to clicks on control links
      if (myself.is('.cancel'))
        // cancel modifications on an existing item
        myself.parents('li:first').load(myself.attr('href') + ' div:first > *');

      if (myself.is('.discard'))
        // discard new item
        myself.parents('li:first').remove();
      if (myself.is('.edit'))
        // in-place edit interface
        myself.parents('li:first').find('div:first')
          .load(myself.attr('href') + ' div:first > *');

      if (myself.is('.new')) {
        // interface for a new item down parent's list
        var mylist = myself.parents('li:first').find('#resume ul.items');
        $('<li></li>')
          .addClass('rank_' + (mylist.children().length + 1))
          .appendTo(mylist)
          .load(myself.attr('href') + ' div:first > *');
      }

      if (myself.is('.destroy')) {
        // destroy an item
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
      }

      // always prevent propagation on control links
      event.preventDefault();
    }

    if (myself.attr('type') &&  myself.attr('type').match(/submit/i)) {
      var to_seek = 'li:first';
      if (myself.attr('value').match(/update/i))
        to_seek += ' div';

      // submitting a form
      var myform = myself.parents('form');
      myself.parents(to_seek).load(myform.attr('action') + ' div:first > *',
        myform.serializeArray());

      event.preventDefault();
    }
  });

  $('#resume ul.items + a.control.new').click(function(event) {
    var mylist = $('#resume ul.items');

    // interface for new root item
    $('<li></li>')
      .addClass('rank_' + (mylist.children().length + 1))
      .appendTo(mylist)
      .load($(this).attr('href') + ' div:first');

    event.preventDefault();
  });

  $('#msgs')
    .ajaxError(function(event, request, options, error) {
      // logging validation errors
      $('#errorExplanation ul.items li', request.responseText)
        .wrapInner('<p></p>').find('p:first').addClass('error')
        .prependTo($(this)).fadeOut(2000, function() { $(this).remove(); });
    })
    .ajaxSuccess(function(event, request, options) {
      // loggin confirmation messages
      $('.notice', request.responseText)
        .prependTo($(this)).fadeOut(2000, function() { $(this).remove(); });
    });
});
