$(window).on('turbolinks:load', function(){
  $('.datepicker').datetimepicker({
    format : "YYYY/MM/DD",
    icons: {
      previous: "fa fa-arrow-left",
      next: "fa fa-arrow-right"
    }
  });

  $('.datetimepicker').datetimepicker({
    format : "YYYY/MM/DD HH:mm",
    minDate: 0,
    icons: {
      time: "fa fa-clock-o",
      date: "fa fa-calendar",
      up: "fa fa-arrow-up",
      down: "fa fa-arrow-down",
      previous: "fa fa-arrow-left",
      next: "fa fa-arrow-right"
    }
  });

  $('#calendar').fullCalendar({
    header: {
      left: 'prev,next today',
      center: 'title',
      right: 'month,agendaWeek,agendaDay'
    },
    navLinks: true,
    selectable: true,
    selectHelper: true,
    displayEventEnd: true,
    timeFormat: 'HH:mm',
    eventColor: '#6d8691',
    events: 'events'
    //editable: true
  });

});
