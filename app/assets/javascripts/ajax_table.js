$(function(){
  $(document).on('click','#provinces th a, #provinces .pagination a',function(){
    $.getScript(this.href);
    return false;
  });

  // Search form
  $('#provinces_search').submit(function () {
    $.get(this.action, $(this).serialize(), null, 'script');
    return false;
  });

  $('#provinces_search input').keyup(function () {
    $.get($('#provinces_search').attr('action'), $('#provinces_search').serialize(), null, 'script');
    return false;
  });
});