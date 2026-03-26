import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.id = this.element.elements.backup_id.value
    this.dialogTarget = this.element.closest("dialog")
  }

  async submit(event) {
    event.preventDefault()

    try {
      const response = await fetch(this.element.action, {
        method: this.element.method,
        body: new FormData(this.element),
        headers: {
          "X-CSRF-Token": document.querySelector("meta[name='csrf-token']")?.content,
          "Accept": "text/javascript"
        }
      })

      if (!response.ok) throw new Error()

      const html = await response.text()

      if (this.rowTarget) {
        this.rowTarget.outerHTML = html
        this.id = html.match(/point_(\d+)/)[1]
        sortLoop(this.rowTarget)
        this.dialogTarget.close()
      } else {
        window.location.reload()
      }
    } catch {
      if (this.rowTarget) {
        this.rowTarget.classList.add("failed")
        this.dialogTarget.close()
      } else {
        window.location.reload()
      }
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
