
/**
 *  
 * @param time
 * @returns {String}
 */
function returnFormattedToSeconds(time){
    var minutes = Math.floor(time / 60),
        seconds = Math.round(time - minutes * 60);

    seconds = seconds < 10 ? '0' + seconds : seconds;

    return minutes + ":" + seconds;
}