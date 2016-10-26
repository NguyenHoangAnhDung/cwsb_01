$(document).ready(function(){
  var venue_id = $('#venue-id').val();
  var times = $('#times').val();
  var checkbox_all = $('#checkbox-all');
  var list_checkbox = $('.cb-confirm');
  checkbox_all.change(function(){
    set_value_for_other_checkboxs(checkbox_all, list_checkbox);
    $("input:checkbox.cb-confirm").prop('checked',this.checked);
    list_checkbox.each(function(){
      var this_checkbox = $(this);
      var this_booking_id = this.id;
      $.ajax({
        type: 'PUT',
        dataType: 'json',
        async: false,
        url: '/bookings/' + this_booking_id,
        data: {booking: {state: this_checkbox.val()}},
        success: function(data){
          display_state(this_checkbox, this_booking_id);
        },
        error: function(XMLHttpRequest, textStatus, errorThrown){
          alert('some error' + textStatus + ' | ' + errorThrown);
        }
      });
    });
  });
  list_checkbox.click(function(){
    var this_checkbox = $(this);
    var this_booking_id = this.id;
    set_value_for_checkbox(this_checkbox);
    update_state(this_booking_id, this_checkbox);
  });
});

function set_value_for_other_checkboxs(checkbox_all, list_checkbox){
  var value_of_checkbox = "";

  if (checkbox_all.prop('checked'))
    value_of_checkbox = "Accepted";
  else
    value_of_checkbox = "Rejected";

  list_checkbox.each(function(){
    var this_checkbox = $(this);
    if (checkbox_all.prop('checked') != this_checkbox.prop('checked')){
      this_checkbox.val(value_of_checkbox);
    }
  });
}
function set_value_for_checkbox(this_checkbox){
  if(this_checkbox.val() == "Pending" || this_checkbox.val() == "Rejected")
    this_checkbox.val("Accepted");
  else
    this_checkbox.val("Rejected");
}
function update_state(this_booking_id, checkbox){
  console.log(checkbox.val());
  $.ajax({
    type: 'PUT',
    dataType: 'json',
    url: '/bookings/' + this_booking_id,
    data: {booking: {state: checkbox.val()}},
    success: function(data){
      console.log(checkbox.val());
      display_state(checkbox, this_booking_id);
    },
    error: function(XMLHttpRequest, textStatus, errorThrown){
      alert('some error' + textStatus + ' | ' + errorThrown);
    }
  });
}
function display_state(checkbox, booking_id){
  var this_state = $('#state-' + booking_id);
  if(checkbox.val() == 'Accepted'){
    this_state.html("Accepted");
  }else{
    this_state.html("Rejected");
  }
}
