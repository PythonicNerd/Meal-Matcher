$(document).ready(function(){


gon.watch('name_')
gon.watch('price')
gon.watch('venuetype')
gon.watch('dist')



$('#new').click(function(){
  event.preventDefault();
  $.ajax({
    url: '/random_swipe/testing123',
    type:'GET',
    dataType:'JSON',
    error: function (xhr, ajaxOptions, thrownError) {
         alert(xhr.responseText);
     },

    success: function(data){
      alert("success")
      alert(data)

    }
  })

})
})





















/*
  $('#change_name').click(function(){
    event.preventDefault();

    function get_index(){
      $.ajax({
        url: '/random_swipe/get_index',
        error: function (xhr, ajaxOptions, thrownError) {
             alert(xhr.responseText);
         },

        success: function(data){
          return data
        }
      })
    }

    get_index()
    rest_index = gon.rest_index
    alert(gon.rest_index)
    alert(rest_index)


    $('#rest_name').text(gon.vl.groups[0].items[rest_index].venue.name)





    dist = $.ajax({
      url: '/random_swipe/find_distance',
      error: function (xhr, ajaxOptions, thrownError) {
           alert(xhr.responseText);
       },

      success: function(){
        console.log("Successful Ajax Pull")

      }
    })


})
*/
