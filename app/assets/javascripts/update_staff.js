$(document).on('turbolinks:load', function(){
  $('.update').click(function(){
    var id = $(this).data('id');
    var role = $('#value_key-'+id).val();
    $.ajax({
      type: 'PUT',
      url: ('/staffs/'+id),
      data: {role: role}
    });
  });
});
