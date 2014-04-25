$(function() {

  var ws = null;

  $(document).ready(function() {
    alert('ready');
    ws = new WebSocket('ws://localhost:4567');
    ws.onopen = function() { };
    ws.onmessage = function(m) {
      document.getElementById('image_tag').src = m.data;
      document.getElementById('sound').Play();
    };
  });

  $(window).unload(function() {    
    console.log('unloading');
    ws.close();
  });

});
