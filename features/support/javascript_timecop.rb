FAKE_TIMERS_JS = File.read(File.expand_path("fake-timers.js", __dir__))

module JavaScriptTimecop
  class << self
    attr_accessor :frozen_time

    def freeze(time)
      self.frozen_time = time
      inject_if_started
    end

    def return
      self.frozen_time = nil
    end

    def install_script
      return unless frozen_time
      timestamp_ms = (frozen_time.to_f * 1000).to_i
      <<~JS
        #{FAKE_TIMERS_JS}
        window.__fake_clock = FakeTimers.install({now: #{timestamp_ms}, toFake: ["Date"]});
      JS
    end

    def reinstall_script
      return unless frozen_time
      timestamp_ms = (frozen_time.to_f * 1000).to_i
      <<~JS
        if (window.__fake_clock) window.__fake_clock.uninstall();
        window.__fake_clock = FakeTimers.install({now: #{timestamp_ms}, toFake: ["Date"]});
      JS
    end

    private

    def inject_if_started
      driver = cuprite_driver
      return unless driver&.instance_variable_get(:@started)
      return unless frozen_time

      page = driver.browser.page

      if (old_id = driver.instance_variable_get(:@timecop_script_id))
        page.command("Page.removeScriptToEvaluateOnNewDocument", identifier: old_id)
      end
      result = page.command("Page.addScriptToEvaluateOnNewDocument", source: install_script)
      driver.instance_variable_set(:@timecop_script_id, result["identifier"])

      Capybara.current_session.execute_script(reinstall_script)
    end

    def cuprite_driver
      driver = Capybara.current_session.driver
      driver.is_a?(Capybara::Cuprite::Driver) ? driver : nil
    end
  end
end

module CupriteJavaScriptTimecopVisit
  def visit(url)
    @started = true
    browser.page

    if (script = JavaScriptTimecop.install_script)
      if @timecop_script_id
        browser.page.command("Page.removeScriptToEvaluateOnNewDocument",
          identifier: @timecop_script_id)
      end
      result = browser.page.command("Page.addScriptToEvaluateOnNewDocument", source: script)
      @timecop_script_id = result["identifier"]
    elsif @timecop_script_id
      browser.page.command("Page.removeScriptToEvaluateOnNewDocument",
        identifier: @timecop_script_id)
      @timecop_script_id = nil
    end

    super
  end

  def reset!
    super
    @timecop_script_id = nil
  end
end

Capybara::Cuprite::Driver.prepend(CupriteJavaScriptTimecopVisit)
