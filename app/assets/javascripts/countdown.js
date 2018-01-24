var Countdown = function(el) {
  el = el || $('countdown')[0];
  this.$el = $(el);

  this.init = function() {
    this.oneMinute = 60 * 1000;
    this.oneHour = this.oneMinute * 60;
    this.oneDay = this.oneHour * 24;
    this.oneYear = this.oneDay * 365;

    this.start = new Date(this.$el.attr("target")).valueOf();
    this.finish = this.start + this.oneDay;
    this.next = this.start + this.oneYear;
    this.now = new Date(this.$el.attr("now")).valueOf();

    var self = this;
    setInterval(function() {
      self.now += 1000;
      self.render()
    }, 1000);

    this.render()
  };

  this.render = function() {
    if(this.now > this.finish) {
      this.start = this.next;
    }

    var diff = Math.abs(this.start - this.now);

    var countdownDay = Math.floor(diff / this.oneDay);
    var countdownHrs = Math.floor(diff % this.oneDay / this.oneHour);
    var countdownMin = Math.floor(diff % this.oneHour / this.oneMinute);
    var countdownSec = Math.floor(diff % this.oneMinute / 1000);

    var current = this.start < this.now && this.now < this.finish;

    this.$el.find("days").html(doubleDigits(countdownDay));
    this.$el.find("hours").html(doubleDigits(countdownHrs));
    this.$el.find("minutes").html(doubleDigits(countdownMin));
    this.$el.find("seconds").html(doubleDigits(countdownSec));
    this.$el.find("waiting").toggle(!current);
    this.$el.find("during").toggle(current);
  };

  function doubleDigits(number) {
    return number < 10 ? "0"+number.toString() : number;
  }

  this.init();
}

$(function() {
  $("countdown").each(function() { new Countdown(this) });
});

