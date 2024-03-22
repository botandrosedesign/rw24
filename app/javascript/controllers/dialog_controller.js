import { Controller, SelectorObserver } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "content",
  ]

  connect() {
    const supportsDialogElement = typeof HTMLDialogElement === 'function'
    if(supportsDialogElement) {
      this.element.hidden = false
      this.observer = new SelectorObserver(document.body, "[rel=ceebox]", this)
      this.observer.start()
    }
  }

  selectorMatchElement(e, details) {
    e.addEventListener("click", event => {
      event.preventDefault()
      this.show(e.href)
    })
  }

  show(url) {
    this.contentTarget.innerHTML = ''
    this.element.show()
    fetch(url).then(r => r.text()).then(html => {
      this.contentTarget.innerHTML = html
    })
  }
}
