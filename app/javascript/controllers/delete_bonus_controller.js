import { Controller } from "@hotwired/stimulus"
import { withActions } from "stimulus-use-actions"

export default class extends withActions(Controller) {
  static actions = {
    element: [
      "ajax:success->success",
      "ajax:error->error",
    ],
  }

  success(event) {
    this.element.closest("tr").remove()
  }

  error(event) {
    alert("Couldn't delete")
  }
}

