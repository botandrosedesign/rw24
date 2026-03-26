import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.pointsTarget = document.getElementById("points")
  }

  async submit(event) {
    event.preventDefault()

    // Fill in computed fields
    const now = new Date().valueOf()
    const start = window.raceStart
    const since_start = now - start
    const since_start_formatted = format_time_diff(since_start)
    this.id = `point_${now}`

    this.element.elements['point[since_start]'].value = since_start_formatted
    const bonus_id = this.element.elements['point[bonus_id]']?.value
    if(bonus_id) {
      this.element.elements['point[qty]'].value = window.bonuses.qty_for_id(bonus_id)
    }

    // Capture form data and add pending row
    const formData = new FormData(this.element)
    this.queryString = new URLSearchParams(formData).toString()
    this.addPendingRow(Object.fromEntries(formData))

    Array.from(this.pointsTarget.children).slice(100).forEach(e => e.remove())

    this.element.reset()
    this.element.querySelector("input[type=number]")?.focus()

    // Submit via fetch
    try {
      const response = await fetch(this.element.action, {
        method: this.element.method,
        body: formData,
        headers: {
          "X-CSRF-Token": document.querySelector("meta[name='csrf-token']")?.content,
          "Accept": "text/javascript"
        }
      })

      if (!response.ok) {
        const text = await response.text()
        this.handleError(text)
        return
      }

      const html = await response.text()
      const row = document.getElementById(this.id)
      row.outerHTML = html
    } catch {
      this.handleError("Network error")
    }
  }

  addPendingRow(data) {
    data.id = this.id
    data.team_position = data['point[team_position]'].padStart(3, '0')
    const template = document.querySelector("#point_template").innerHTML
    const html = Mu(template, data)
    this.pointsTarget.insertAdjacentHTML("afterBegin", html)
  }

  handleError(text) {
    const row = document.getElementById(this.id)
    row.classList.remove("pending")
    row.classList.add("failed")
    const td = row.querySelector("td:last-child")
    td.innerHTML = `
      <a href="/points/new?id=${this.id}&${this.queryString}" class="edit" title="New Score" rel="ceebox">Edit</a>
      <a href="#" onclick="this.closest('tr').remove(); return false" class="delete">Delete</a>
    `
    td.previousElementSibling.innerText = text
  }
}

function format_time_diff(diff) {
  const oneMinute = 60 * 1000
  const oneHour = oneMinute * 60

  const hours = Math.floor(diff / oneHour)
  const minutes = Math.floor(diff % oneHour / oneMinute)
  const seconds = Math.floor(diff % oneMinute / 1000)

  return [hours, minutes, seconds].map(n =>
    n.toString().padStart(2, '0')
  ).join(":")
}

function Mu(e,t){return e.replace(/@(\w+)="([^"]+)"/g,(e,o,t)=>`on${o}="${t.replace(/\bthis\b/g,"getRootNode().host")}"`).replace(/{{([^}]+)}}/g,(e,o)=>t[o])}
