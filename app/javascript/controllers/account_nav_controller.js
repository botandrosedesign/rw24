import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "loggedOut",
    "loggedIn",
  ]

  connect() {
    const target = this.#cookieUID() ? this.loggedInTarget : this.loggedOutTarget
    target.style.display = 'inherit'
  }

  #cookieUID() {
    return document.cookie.match(/(^|;)\s*uid=([^;\s]+)/)
  }
}

