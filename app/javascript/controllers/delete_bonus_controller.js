import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  async click(event) {
    event.preventDefault()

    if (!confirm(this.element.dataset.confirm)) return

    try {
      const response = await fetch(this.element.href, {
        method: "DELETE",
        headers: {
          "X-CSRF-Token": document.querySelector("meta[name='csrf-token']")?.content,
          "Accept": "text/javascript"
        }
      })

      if (!response.ok) throw new Error()

      this.element.closest("tr").remove()
    } catch {
      alert("Couldn't delete")
    }
  }
}
