import { Controller } from "@hotwired/stimulus"
import "@kollegorna/cocoon-vanilla-js"
import autocomplete from 'autocompleter'
import renderShirtSizeCounts from "lib/render_shirt_size_counts"

export default class extends Controller {
  connect() {
    wireUpAutocomplete(this.element)
  }
}

function wireUpAutocomplete(field) {
  const $field = $(field)
  const $input = $field.next()
  const $fieldset = $field.closest(".rider-field")
  const users = $field.data("autocomplete")

  autocomplete({
    input: field,
    container: document.createElement("ul"),
    className: "autocomplete",
    fetch: (text, update) => {
      const matchedUsers = users.filter(user => {
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
        $field.val(user.label)
        $fieldset.find("input[name$='[user_id]']").val(user.user_id)
        $fieldset.find("input[name$='[name]']").val(user.name)
        $fieldset.find("input[name$='[email]']").val(user.email)
        $fieldset.find("input[name$='[phone]']").val(user.phone)
        $fieldset.find("select[name$='[shirt_size]']").val(user.shirt_size)
        renderShirtSizeCounts()
      } else {
        $.post({
          url: `/admin/users/${user.user_id}/resend_confirmation.js`,
          dataType: "script",
          success: (event) => Flash.notice(`Confirmation email resent to ${user.email}`)
        })
        $field.val(null)
      }
    },
    minLength: 1,
  })
}

const h = html => {
  const container = document.createElement("div")
  container.innerHTML = html
  return container.firstElementChild
}
