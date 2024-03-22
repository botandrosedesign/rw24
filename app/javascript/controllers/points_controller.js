import { Controller } from "@hotwired/stimulus"
import useActions from "stimulus-use-actions"

export default class extends Controller {
  connect() {
    useActions(this, {
      element: [
        "ajax:before->before",
        "ajax:beforeSend->beforeSend",
        "ajax:success->success",
        "ajax:error->error",
      ],
    })
    this.pointsTarget = document.getElementById("points")
  }

  before(event) {
    const now = new Date().valueOf()
    const start = window.raceStart
    const since_start = now - start
    const since_start_formatted = format_time_diff(since_start)
    this.id = `point_${now}`

    this.element.elements['point[since_start]'].value = since_start_formatted
    const bonus_id = this.element.elements['point[bonus_id]']?.value
    let qty = this.element.elements['point[qty]']?.value
    if(bonus_id) {
      let qty = window.bonuses.qty_for_id(bonus_id)
      this.element.elements['point[qty]'].value = qty
    }
  }

  beforeSend(event) {
    const formData = new FormData(this.element)
    this.queryString = new URLSearchParams(formData).toString()
    this.addPendingRow(Object.fromEntries(formData))

    Array.from(this.pointsTarget.children).slice(100).forEach(e => e.remove())

    this.element.reset()
    this.element.querySelector("input[type=number]")?.focus()
  }

  addPendingRow(data) {
    data.id = this.id
    data.team_position = data['point[team_position]'].padStart(3, '0')
    var template = document.querySelector("#point_template").innerHTML
    var html = Mu(template, data)
    this.pointsTarget.insertAdjacentHTML("afterBegin", html)
  }

  success(event) {
    const row = document.getElementById(this.id)
    row.outerHTML = event.detail[0]
  }

  error(event) {
    const row = document.getElementById(this.id)
    row.classList.remove("pending")
    row.classList.add("failed")
    const td = row.querySelector("td:last-child")
    td.innerHTML = `
      <a href="/points/new?id=${this.id}&${this.queryString}" class="edit" title="New Score" rel="ceebox">Edit</a>
      <a href="#" onclick="this.closest('tr').remove(); return false" class="delete">Delete</a>
    `
    td.previousElementSibling.innerText = event.detail[0]
  }
}

function format_time_diff(diff) {
  var oneMinute = 60 * 1000
  var oneHour = oneMinute * 60

  var hours = diff / oneHour
  var minutes = diff % oneHour / oneMinute
  var seconds = diff % oneMinute / 1000

  return [hours, minutes, seconds].filter(e=>e).map(n => {
    Math.floor(n).toString().padStart(2, '0')
  }).join(":")
}

function Mu(e,t){return e.replace(/@(\w+)="([^"]+)"/g,(e,o,t)=>`on${o}="${t.replace(/\bthis\b/g,"getRootNode().host")}"`).replace(/{{([^}]+)}}/g,(e,o)=>t[o])}

