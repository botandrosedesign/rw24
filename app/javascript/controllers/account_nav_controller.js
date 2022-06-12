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
    const name = "uid"
    const cookie = document.cookie.match(new RegExp('(^|;)\\s*' + escape(name) + '=([^;\\s]+)'))
    return !!cookie
  }
}

