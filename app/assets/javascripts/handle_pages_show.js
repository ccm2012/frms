$(document).on('turbolinks:load', function (){
  $('.direct').click(function(){
    var direct = $(this).attr('id');
    $('.active').removeClass('active');
    $(this).addClass('active');
    if (direct == 'nil'){
      $('.to-direct').each(function() {
        $(this).fadeIn('slow');
      });
    } else {
      $('.to-direct').each(function() {
        if ($(this).hasClass(direct)) {
          $(this).fadeIn('fast');
        } else {
          $(this).fadeOut('slow');
        }
      });
    }
  });
});
