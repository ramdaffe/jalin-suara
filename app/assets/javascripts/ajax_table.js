$(function(){
  // $('#provinces_search input').keyup(function () {
  //   $.get($('#provinces_search').attr('action'), $('#provinces_search').serialize(), null, 'script');
  //   return false;
  // });

  // $('#districts_search input').keyup(function () {
  //   $.get($('#districts_search').attr('action'), $('#districts_search').serialize(), null, 'script');
  //   return false;
  // });

  $(document).on('click','th a, .pagination a',function(){
    $.getScript(this.href);
    return false;
  });

  $('#table_search').submit(function () {
    $.get(this.action, $(this).serialize(), null, 'script');
    return false;
  });
});