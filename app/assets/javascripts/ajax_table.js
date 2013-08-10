$(document).on('click','#provinces th a',function(){
  $.getScript(this.href);
  return false;
});