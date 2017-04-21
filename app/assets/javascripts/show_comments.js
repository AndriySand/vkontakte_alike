$(function(){
  toggle_comments_view();
  $('.table-comments').on('click', '.edit-comment, .update-comment, .cancel-update', function(){
    first_td = find_td(this, 'td:first-child');
    if($(this).hasClass('update-comment') && first_td.next().find('.message').text().length > 0){
      return false;
    } else {
      first_td.toggle();
      first_td.next().toggle();
      last_td = find_td(this, 'td:last-child');
      last_td.toggle();
      last_td.prev().toggle();
    }
    if($(this).hasClass('edit-comment')){
      $('.fcomment').enableClientSideValidations();
    }
    if($(this).hasClass('update-comment')){
      form_td_id = '#' + find_td(this, '.fcomment').prop('id');
      value_td_id = '#' + find_td(this, '.comment-content').prop('id');
      $.ajax({
        url: $(form_td_id).attr('action'),
        type: "PATCH",
        data: $(form_td_id).serialize(),
        dataType: 'html',
        success: function(data){
          $(value_td_id).replaceWith(data);
        }
      });
    }
    return false;
  });
  $('#create-comment').on('submit', function(){
    selector = '#create-comment .form-content';
    $(document).ajaxSuccess(function(){
      $(selector).prop('value', '');
      toggle_comments_view();
    });
  });
  $('.delete-comment').on('click', function(){
    toggle_comments_view();
  });
  if ($('#infinite-scrolling').size() > 0){
    $('.comment-rows').on('scroll', function(){
      more_comments_url = $('.pagination .next_page a').attr('href');
      if (more_comments_url && $('.comment-rows').scrollTop() > $('.table-comments tbody').height() - 170){
        $('.pagination').html('<img src="/assets/spinner.gif" alt="Loading..." title="Loading..." />');
        $.ajax({
          url: more_comments_url,
          type: "GET",
          dataType: 'script'
        });
      }
    });
  };
});

function find_td(start_el, expr){
  return $(start_el).parents('tr').find(expr);
}

function toggle_comments_view(){
  if(comments_exist() && div_visibility() || !comments_exist() && !div_visibility()){
    $('div.comments').toggle();
    $('div.no-comments').toggle();
  }
}

function comments_exist(){
  if($('td.comment-content').length > 0){
    return true;
  }
}

function div_visibility(){
  if($('div.no-comments').is(':visible')){
    return true;
  }
}
