$(function() {
  var update_date = function() {
    var oneMinute = 60 * 1000;
    var oneHour = oneMinute * 60;
    var oneDay = oneHour * 24;
    var oneYear = oneDay * 365;

    var now = new Date().valueOf();
    // "Sat Jul 31 01:00:00 UTC 2010"
    var start = new Date(Date.UTC(2011, 6, 30, 0, 0, 0)).valueOf();
    // "Sat Aug 01 01:00:00 UTC 2010"
    var finish = new Date(Date.UTC(2011, 6, 31, 0, 0, 0)).valueOf();
    // "Sat Jul 31 01:00:00 UTC 2011"
    var next = new Date(Date.UTC(2012, 6, 27, 0, 0, 0)).valueOf();
    
    var current = start < now && now < finish

    if(now > finish) {
      start = next;
    }

    var diff = Math.abs(start - now);

    var countdownDay = Math.floor(diff / oneDay);
    var countdownHrs = Math.floor(diff % oneDay / oneHour);
    var countdownMin = Math.floor(diff % oneHour / oneMinute);
    var countdownSec = Math.floor(diff % oneMinute / 1000);

    $("#day b").html(countdownDay < 10 ? "0"+countdownDay.toString() : countdownDay);
    $("#hrs b").html(countdownHrs < 10 ? "0"+countdownHrs.toString() : countdownHrs);
    $("#min b").html(countdownMin < 10 ? "0"+countdownMin.toString() : countdownMin);
    $("#sec b").html(countdownSec < 10 ? "0"+countdownSec.toString() : countdownSec);

    if(current) {
      $("#countdown p.countup").hide();
      $("#countdown p.countdown").show();
    } else {
      $("#countdown p.countup").show();
      $("#countdown p.countdown").hide();
    }
    $("#countdown").css("visibility", "");
  };

  setInterval(update_date, 1000);
});
