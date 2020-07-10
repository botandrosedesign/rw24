require "capybara/headless_chrome/cucumber"

Then "I should download a file named {string}" do |filename|
  page.downloads[filename]
end

Then "I should download a CSV named {string} with the following contents:" do |filename, table|
  file = page.downloads[filename]
  actual = CSV.parse(file.read).to_a
  table.diff! actual
end

Then "I should download a file named {string} with the following contents:" do |filename, contents|
  file = page.downloads[filename]
  actual = file.read
  expect(contents.strip).to eq actual.strip
end

Then "I should download a zip file named {string} containing the following files:" do |filename, table|
  file = page.downloads[filename]
  actual = Zip::File.open(file.path).entries.map { |entry| [entry.name] }
  table.diff! actual
end

