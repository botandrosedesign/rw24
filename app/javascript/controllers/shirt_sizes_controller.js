import { Controller } from "@hotwired/stimulus"
import { withActions } from "stimulus-use-actions"

export default class extends withActions(Controller) {
  static targets = [
    "input",
    "output",
  ]

  static actions = {
    // FIXME doesn't work with targets added after initialization
    // inputTargets: "render",
    window: "cocoon:after-remove->render",
  }

  render() {
    this.outputTargets.forEach(e => e.value = 0)
    const selectedSizes = this.inputTargets.map(e => e.value)
    selectedSizes.forEach(size => {
      if(size.length == 0) return
      const field = this.outputTargets.find(e => e.name.match(`\\[${size}\\]$`))
      let count = parseInt(field.value) || 0
      count += 1
      field.value = count
    })
  }
}

