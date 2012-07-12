// Commands that can be executed by the code running directly on the phone
var commands=[];
// Store current location
document.last_loc={};
// Handle location data
commands.geolocationSuccess=function(position) {
  document.last_loc=position;
  map.panTo(new google.maps.LatLng(position.latitude, position.longitude));
};

function pushPosition() {
    $.post('https://spy-game.herokuapp.com/games/'+document.game_id+'/update_position', document.last_loc, handle_update, 'json');
}

// Handle an error while trying to get location
commands.geolocationError=function(error) {
    $('#content').append('<p style="background-color: red">'+error+'</p>');
};

// Listen to commands sent by the code running directly on the phone
pm.bind("command", function(data) {
    return commands[data.cmd](data.args);
}, "file://");

// Send a command to the native phone code
function remoteCmd(cmd, args, success, error) {
    pm({
        target: window.parent,
        type: "command",
        data: {cmd: cmd, args: args},
        success: success,
        error: error
    });
//    alert('Sent '+cmd);
}

// Commands to be run directly on the phone
function watchPosition() {
  remoteCmd('watchPosition');
}
function clearWatch() {
  remoteCmd('clearWatch');
}
function getPosition() {
  remoteCmd('getPosition');
}
function exitApp() {
    remoteCmd('exit');
}

// Handle game state data (after posting to /update_position in commands.geolocationSuccess)
function handle_update(data, textStatus, jXHR) {
  if (data.goto) {
    document.location=data.goto;
  } else {
    update_positions(data);
  }
}

$(document).bind("mobileinit", function(){
  $.mobile.ajaxEnabled = false;
  setInterval(pushPosition, 10000);
});
