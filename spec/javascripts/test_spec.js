//= require test
describe("Testing framework", function() {
    it('should work', function() {
	expect(true).toBe(true);
    });
    it('should say hello', function() {
	expect(hello()).toBe("hello");
    });
});
