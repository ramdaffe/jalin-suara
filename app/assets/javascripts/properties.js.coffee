jQuery ->
  subdistrict_names = $('#subdistrict_id').html()
  $('#role_name').change ->
    role_name = $('#role_name :selected').text()
    escaped_role_name = role_name.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(subdistrict_names).filter("optgroup[label='#{escaped_role_name}']").html()
    if options
      $('#subdistrict_id').html(options)
    else
      $('#subdistrict_id').empty()