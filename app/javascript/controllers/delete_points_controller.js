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

      this.rowTarget.remove()
    } catch {
      this.rowTarget.classList.add("failed")
      this.element.parentElement.innerHTML = `
        Couldn't delete.
        <a href="#" onclick="this.closest('tr').remove(); return false">Clear</a>
      `
    }
  }

  get rowTarget() {
    return this.element.closest("tr")
  }
}
