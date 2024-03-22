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
    this.dialogTarget = this.element.closest("dialog")
  }

  // retry: true,

  success(event) {
    if(this.rowTarget) {
      const html = event.detail[0]
      this.rowTarget.outerHTML = html
      this.id = html.match(/point_(\d+)/)[1]
      sortLoop(this.rowTarget)
      this.dialogTarget.close()
    } else {
      window.location.reload()
    }
  }

  error(event) {
    if(this.rowTarget) {
      this.rowTarget.classList.add("failed")
      this.dialogTarget.close()
    } else {
      window.location.reload()
    } 
  }

  get rowTarget() {
    return document.getElementById(`point_${this.id}`)
  }
}

function sortLoop(el) {
  const next = el.nextElementSibling
  if(next) {
    const a = el.querySelector(".sort").innerText
    const b = next.querySelector(".sort").innerText
    if(a < b) {
      next.parentNode.insertBefore(next, el)
      sortLoop(el)
    }
  }
}

