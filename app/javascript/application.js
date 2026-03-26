import "@hotwired/turbo-rails"
import "controllers"

// Disable Turbo Drive globally — the app isn't ready for SPA-style navigation.
// Turbo is still used for data-turbo-method and data-turbo-confirm on opted-in links.
Turbo.session.drive = false

// Handle data-confirm on non-Turbo elements (form buttons/inputs)
document.addEventListener("click", (event) => {
  if (event.defaultPrevented) return
  const element = event.target.closest("[data-confirm]")
  if (element && !confirm(element.dataset.confirm)) {
    event.preventDefault()
  }
})
