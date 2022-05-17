require "execjs/module"
require "execjs/external_runtime"

ExecJS.runtime = ExecJS::ExternalRuntime.new({
  name:        "Vendored Node.js (V8)",
  command:     File.expand_path("bin/node"),
  runner_path: ExecJS.root + "/support/node_runner.js",
  encoding:    "UTF-8",
})

