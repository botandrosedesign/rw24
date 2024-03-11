import { Controller } from "@hotwired/stimulus"
import useActions from "stimulus-use-actions"

export default class extends Controller {
  connect() {
    useActions(this, {
      element: [
        "ajax:success->success",
        "ajax:error->error",
      ],
    })
  }

  // retry: true,

  success(event) {
    this.rowTarget.remove()
  }

  error(event) {
    this.rowTarget.classList.add("failed")
    this.parentElement.innerHTML = `
      Couldn't delete.
      <a href="#" onclick="this.closest("tr").remove(); return false">Clear</a>
    `
  }

  get rowTarget() {
    return this.element.closest("tr")
  }
}

