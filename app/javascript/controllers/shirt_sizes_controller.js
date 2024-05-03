import { Controller } from "@hotwired/stimulus"
import useActions from "stimulus-use-actions"

export default class extends Controller {
  static targets = [
    "input",
    "output",
  ]

  connect() {
    useActions(this, {
      // FIXME doesn't work with targets added after initialization
      // inputTargets: "render",
      window: "cocoon:after-remove->render",
    })  
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

