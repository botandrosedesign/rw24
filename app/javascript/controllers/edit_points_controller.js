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
    this.id = this.element.elements.backup_id.value 
    this.buttonTarget = document.getElementById("cee_closeBtn")
  }

  // retry: true,

  success(event) {
    const html = event.detail[0]
    this.rowTarget.outerHTML = html
    this.id = html.match(/point_\d+/)[0]
    sortLoop(this.rowTarget)
    this.buttonTarget.click()
  }

  error(event) {
    this.rowTarget.classList.add("failed")
    this.buttonTarget.click()
  }

  get rowTarget() {
    return document.getElementById(this.id)
  }
}

function sortLoop(el) {
  var next = el.nextElementSibling
  var a = el.querySelector(".sort").innerText
  var b = next.querySelector(".sort").innerText
  if(a < b) {
    next.parentNode.insertBefore(next, el)
    sortLoop(el)
  }
}

