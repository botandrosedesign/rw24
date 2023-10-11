import { Controller } from "@hotwired/stimulus"
import renderShirtSizeCounts from "lib/render_shirt_size_counts"

export default class extends Controller {
  connect() {
    const selector = ".nested-fields"
    $(this.element).change(function() {
      const desiredLength = $("option:selected", this.element).data("max")
      const actualLength = $(selector).length

      if(desiredLength > actualLength) {
        Array.from(Array(desiredLength - actualLength)).map((_, i) => {
          $("[data-association='rider']")[0].click()
        })
      }

      if(actualLength > desiredLength) {
        Array.from(Array(actualLength - desiredLength)).map((_, i) => {
          $(`${selector} .remove_fields`).get(i).click()
        })
      }
    })

    $("body")
      .on("cocoon:after-remove", () => renderShirtSizeCounts())
      .on("change", "select", () => renderShirtSizeCounts())
  }
}
