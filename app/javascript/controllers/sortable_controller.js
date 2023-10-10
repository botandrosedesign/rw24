import { Controller } from "@hotwired/stimulus"
import { put } from "rails-request-json"
import Sortable from "sortablejs"

export default class extends Controller {
  connect() {
    this.sortable = Sortable.create(this.element, {
      animation: 0,
      ghostClass: "not-visible",
      onSort: () => this.onSort()
    })
  }

  onSort() {
    const url = "bonuses"
    const bonuses = Array.from(this.element.children).map(e => e.dataset.attributes)
    put(url, { bonuses: bonuses })
  }
}


