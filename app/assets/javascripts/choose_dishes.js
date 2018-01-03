$(document).on('turbolinks:load', function(){
  $('.dish').each(function() {
    if ($(this).is(':checked')) {
      var h = '<li id="'+$(this).val()+'" class="dish-category"><strong>'+$(this).attr('name')+'</strong></li>';
      $('#las').append(h);
    }
  });
  $('.dish').click(function() {
    if ($(this).is(':checked')) {
      var h = '<li id="'+$(this).val()+'" class="dish-category"><strong>'+$(this).attr('name')+'</strong></li>';
      $('#las').append(h);
    }else {
      $('#'+($(this).val())).remove();
    }
  });
  $('#submit').click(function() {
    var turn = [];
    $('.dish').each(function() {
      if ($(this).is(':checked')) {
        turn.push($(this).val());
      }
    });
    var k = '<input id="dishes" name="dishes" type="hidden" value="'+turn+'">';
    $('#las').append(k);
  });
});
