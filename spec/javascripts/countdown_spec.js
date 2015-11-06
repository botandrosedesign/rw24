//= require jquery
//= require countdown

describe('Countdown', function() {
    before(function() {
	this.countFixture = $("<div class='countstart' data-countstart=''></div>");
    });
    
    beforeEach(function() {
	countdown.init();
    });
    afterEach(function() {
	
    });

    it('should exist', function() {
	expect(countdown).toBeDefined();
    });

    it('should init with proper time measurements', function() {
	expect(countdown.oneMinute).toBe(60 * 1000);
	expect(countdown.oneHour).toBe(60 * 1000 * 60);
	expect(countdown.oneDay).toBe(60 * 1000 * 60 * 24);
	expect(countdown.oneYear).toBe(60 * 1000 * 60 * 24 * 365);
    });
});
