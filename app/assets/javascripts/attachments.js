$(function(){
  $('.attachment').on('click', function(){
    $('#attachment_links').toggle();
    if($('#comments_attachment').is(':visible')){
      $('#comments_attachment').toggle();
    };
    return false;
  });
  $('.attach_comment').on('click', function(){
    $('#attachment_links').toggle();
    $('#comments_attachment').toggle();
    return false;
  });
  $('.attach_article').on('click', function(){
    $('#attachment_links').toggle();
    $('#articles_attachment').toggle();
    return false;
  });
  $('.attach_file').on('click', function(){
    $('.attachment-upload').toggle();
    $('#attachment_links').toggle();
    $(window).scrollTop($('.attachment-upload').offset().top);
    return false;
  });
  $('.title_control').on('click', function(){
    $('#attachment_links').toggle();
    $(this).parent().parent().toggle();
    return false;
  });
});

