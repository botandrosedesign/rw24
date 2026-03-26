import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["field"]

  async submit(event) {
    event.preventDefault()

    this.fieldTarget.indeterminate = true
    document.getElementById("flash_notice").innerText = ""
    document.getElementById("flash_alert").innerText = ""

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

      this.fieldTarget.indeterminate = false
      const verb = this.fieldTarget.checked ? "assigned to" : "removed from"
      const teamId = this.fieldTarget.id.split("_").at(-1)
      document.getElementById("flash_notice").innerText = `Bonus ${verb} team ${teamId}`
    } catch {
      const verb = this.fieldTarget.checked ? "assign bonus to" : "removed bonus from"
      const teamId = this.fieldTarget.id.split("_").at(-1)
      document.getElementById("flash_alert").innerText = `Couldn't ${verb} team ${teamId}! Check your internet connection?`
    }
  }

  click() {
    this.element.requestSubmit()
  }
}
