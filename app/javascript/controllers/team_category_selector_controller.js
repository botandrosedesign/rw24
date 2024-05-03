import { Controller } from "@hotwired/stimulus"
import useActions from "stimulus-use-actions"

export default class extends Controller {
  connect() {
    useActions(this, {
      element: "change",
    })
  }

  change() {
    const selector = ".nested-fields"
    const desiredLength = parseInt(this.element.selectedOptions[0].dataset.max)
    const actualLength = document.querySelectorAll(selector).length

    if(desiredLength > actualLength) {
      times(desiredLength - actualLength, () => {
        const addButton = document.querySelector("[data-association='rider']")
        addButton.click()
      })
    }

    if(actualLength > desiredLength) {
      times(actualLength - desiredLength, x => {
        setTimeout(() => { // apparently remove is async
          const removeButton = Array.from(document.querySelectorAll(`${selector} .remove_fields`)).at(-1)
          removeButton.click()
        }, 10 * x)
      })
    }
  }
}

function times(x, fn) {
  while(x--) {
    fn(x)
  }
}
