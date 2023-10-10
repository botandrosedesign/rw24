pin_all_from "app/javascript/controllers", under: "controllers"
pin_all_from "app/javascript/lib", under: "lib"

pin "importmap_application", preload: true
pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.0.1/dist/stimulus.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true

pin "sortablejs", to: "https://ga.jspm.io/npm:sortablejs@1.15.0/Sortable.js"
pin "rails-request-json", to: "https://ga.jspm.io/npm:rails-request-json@0.0.1/index.js"
pin "@rails/request.js", to: "https://ga.jspm.io/npm:@rails/request.js@0.0.8/src/index.js"
