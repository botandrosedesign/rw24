import { Controller } from "@hotwired/stimulus"
import "@kollegorna/cocoon-vanilla-js"
import autocomplete from 'autocompleter'
import { post } from "rails-request-json"

export default class extends Controller {
  static targets = [
    "field",
  ]

  connect() {
    autocomplete({
      input: this.fieldTarget,
      container: document.createElement("ul"),
      className: "autocomplete",
      fetch: (text, update) => {
        const matchedUsers = window.riderAutocompleteOptions.filter(user => {
          return user.label.toLowerCase().includes(text.toLowerCase())
        })
        update(matchedUsers)
      },
      render: user => {
        let text = user.label
        if(!user.verified) { text = `<span style='color: red'>UNCONFIRMED</span> ${text}` }
        if(user.team_pos) { text = `<span style='color: red'>#${user.team_pos}</span> ${text}` }
        return h(`<li><div>${text}</div></li>`)
      },
      onSelect: user => {
        if(user.verified) {
          this.fieldTarget.value = user.label
          this.element.querySelector("input[name$='[user_id]']").value = user.user_id
          this.element.querySelector("input[name$='[name]']").value = user.name
          this.element.querySelector("input[name$='[email]']").value = user.email
          this.element.querySelector("input[name$='[phone]']").value = user.phone
          const e = this.element.querySelector("select[name$='[shirt_size]']")
          e.value = user.shirt_size
          e.dispatchEvent(new Event('change'))
        } else {
          post(`/admin/users/${user.user_id}/resend_confirmation.js`).then(() => {
            alert(`Confirmation email resent to ${user.email}`)
          })
          this.fieldTarget.value = null
        }
      },
      minLength: 1,
    })
  }
}

const h = html => {
  const container = document.createElement("div")
  container.innerHTML = html
  return container.firstElementChild
}
