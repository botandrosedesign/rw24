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

  success(event) {
    this.closest("tr").remove()
  }

  error(event) {
    alert("Couldn't delete")
  }
}

