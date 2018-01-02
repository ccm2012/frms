$(document).on('turbolinks:load', function(){
  $('.category').each(function() {
    if ($(this).is(':checked')) {
      var h = '<span id="'+$(this).val()+'" class="dish-category"><strong>'+$(this).attr('name')+'</strong></span>';
      $('#las').append(h);
    }
  });
  $('.category').click(function() {
    if ($(this).is(':checked')) {
      var h = '<span id="'+$(this).val()+'" class="dish-category"><strong>'+$(this).attr('name')+'</strong></span>';
      $('#las').append(h);
    }else {
      $('#'+($(this).val())).remove();
    }
  });
  $('#submit').click(function() {
    var turn = [];
    $('.category').each(function() {
      if ($(this).is(':checked')) {
        turn.push($(this).val());
      }
    });
    var k = '<input id="categories" name="categories" type="hidden" value="'+turn+'">';
    $('#las').append(k);
  });
});
