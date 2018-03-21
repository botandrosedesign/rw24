class AjaxWaiter
  def self.wait!
    new.wait!
  end

  def initialize capybara_session, start_time=Time.now
    self.capybara_session = capybara_session
    self.start_time = start_time
  end

  attr_accessor :capybara_session, :start_time

  def wait!
    loop do
      sleep 0.10
      break if jquery_idle?
      echo "Timed out waiting for ajax to resolve" && break if timed_out?
    end
  end

  private

  def jquery_idle?
    capybara_session.evaluate_script "jQuery && jQuery.isReady && jQuery.active==0"
  end

  def timed_out?
    (start_time + Capybara.default_max_wait_time) < Time.now
  end
end

def wait_for_ajax
  AjaxWaiter.new(page).wait!
end

