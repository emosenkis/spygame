var commands=[];
commands.exit=function () {
    navigator.app.exitApp();
};
commands.getPosition=function () {
    navigator.geolocation.getCurrentPosition(geolocationSuccess, geolocationFailure, {enableHighAccuracy: true});
};
commands.watchPosition=function() {
    commands.clearWatch();
    document.watch_id=navigator.geolocation.watchPosition(geolocationSuccess, geolocationFailure, {enableHighAccuracy: true});
};
commands.clearWatch=function() {
    if (typeof document.watch_id !== 'undefined') {
        navigator.geolocation.clearWatch(document.watch_id);
        alert('Cleared watch');
    } else {
        alert('No watch to clear');
    }
};
function geolocationSuccess(position) {
    alert('GPS good');
    remoteCmd('geolocationSuccess', position);
}
function geolocationFailure(error) {
    alert('GPS bad');
    remoteCmd('geolocationError', error.message);
}
pm.bind("command", function(data) {
    alert('Running '+data.cmd);
    return commands[data.cmd](data.args);
}, "http://people.brandeis.edu");
function remoteCmd(cmd, args, success, error) {
    pm({
        target: window.frames[0],
        type: "command",
        data: {cmd: cmd, args: args},
        success: success,
        error: error
    });
}
