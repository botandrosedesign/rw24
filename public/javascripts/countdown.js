$(function() {
  var update_date = function() {
    var oneMinute = 60 * 1000;
    var oneHour = oneMinute * 60;
    var oneDay = oneHour * 24;
    var oneYear = oneDay * 365;

    var today = new Date().valueOf();
    var target = new Date('7/30/2010 19:00').valueOf();

    var diff = target - today;

    var countdownDay = Math.floor(diff / oneDay);
    var countdownHrs = Math.floor(diff % oneDay / oneHour);
    var countdownMin = Math.floor(diff % oneHour / oneMinute);
    var countdownSec = Math.floor(diff % oneMinute / 1000);

    $('#day b').html(countdownDay < 10 ? '0'+countdownDay.toString() : countdownDay);
    $('#hrs b').html(countdownHrs < 10 ? '0'+countdownHrs.toString() : countdownHrs);
    $('#min b').html(countdownMin < 10 ? '0'+countdownMin.toString() : countdownMin);
    $('#sec b').html(countdownSec < 10 ? '0'+countdownSec.toString() : countdownSec);
  };

  setInterval(update_date, 1000);
});
