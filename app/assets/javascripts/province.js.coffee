jQuery ->
  $('#district').hide()
  $('#subdistrict').hide()
  $('.control-group.activity').hide()
  districts = $('#district').html()
  $('#province').change ->
    province = $('#province :selected').text()
    escaped_province = province.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(districts).filter("optgroup[label='#{escaped_province}']").html()
    if options
      $('#district').html(options)
      $('#district').show()
    else
      $('#district').empty()
      $('#district').hide()
  subdistricts = $('#subdistrict').html()
  $('#district').focus ->
    district = $('#district :selected').text()
    escaped_district = district.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(subdistricts).filter("optgroup[label='#{escaped_district}']").html()
    if options
      $('#subdistrict').html(options)
      $('#subdistrict').show()
    else
      $('#subdistrict').empty()
      $('#subdistrict').hide()
  $('#district').change ->
    district = $('#district :selected').text()
    escaped_district = district.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(subdistricts).filter("optgroup[label='#{escaped_district}']").html()
    if options
      $('#subdistrict').html(options)
      $('#subdistrict').show()
    else
      $('#subdistrict').empty()
      $('#subdistrict').hide()
  activities = $('#activity').html()
  $('#subdistrict').focus ->
    subdistrict = $('#subdistrict :selected').text()
    escaped_subdistrict = subdistrict.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(activities).filter("optgroup[label='#{escaped_subdistrict}']").html()
    if options
      $('#activity').html(options)
      $('.control-group.activity').show()
    else
      $('#activity').empty()
      $('.control-group.activity').hide()
  $('#subdistrict').change ->
    subdistrict = $('#subdistrict :selected').text()
    escaped_subdistrict = subdistrict.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(activities).filter("optgroup[label='#{escaped_subdistrict}']").html()
    if options
      $('#activity').html(options)
      $('.control-group.activity').show()
    else
      $('#activity').empty()
      $('.control-group.activity').hide()