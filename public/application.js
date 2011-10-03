$(function(){
  $('#comment').submit(function() {
    $.post($(this).attr('action'), $(this).serialize(), function(data){
    });
    return false;
  });
  var new_uuid;
  $("#file").change(function(){
    if(new_uuid!=null){
      $(".uuid").each(function(index){
        $(this).val(new_uuid);
      });
    }
    $(this).parent('form').submit();
    $(".meter-value").width('0%');
    $("#progress").html('0%');
    var timeout_id = setTimeout(updateProgress, 2000);
  });
  function updateProgress(){
    $.getJSON('/progress',{
      uuid:$("#uuid").attr('value')
    },function(response){
      if (response.result<100){
        setTimeout(updateProgress, 1000);
      }
      if (response.result==-1) {
        $("#progress").html("Not available.")
      }else{
        new_uuid = response.new_uuid;
        $(".meter-value").width(response.result+'%');
        $("#progress").html(response.result+'%');
      };
    });
  }
});
