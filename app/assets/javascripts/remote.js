var commands=[];
commands.geolocationSuccess=function(position) {
    $('#content').append('<p>You are within '+position.coords.accuracy+' meters of '+position.coords.latitude+', '+position.coords.longitude+'</p>');
};
commands.geolocationError=function(error) {
    $('#content').append('<p style="background-color: red">'+error+'</p>');
};
pm.bind("command", function(data) {
    return commands[data.cmd](data.args);
}, "file://");
function exitApp() {
    remoteCmd('exit');
}
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
