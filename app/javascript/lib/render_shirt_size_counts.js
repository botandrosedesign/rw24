export default function renderShirtSizeCounts() {
  Array.from(document.querySelectorAll(".all-shirt-fields input")).forEach(e => e.value = 0)
  const selectedSizes = Array.from(document.querySelectorAll("select[name$='[shirt_size]']")).map(e => e.value)
  selectedSizes.forEach(size => {
    if(size.length == 0) return
    const field = document.querySelector(`input[name$='[${size}]']`)
    let count = parseInt(field.value) || 0
    count += 1
    field.value = count
  })
}

