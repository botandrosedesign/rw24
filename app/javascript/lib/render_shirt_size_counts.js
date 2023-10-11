export default function renderShirtSizeCounts() {
  $(".all-shirt-fields input").val(0)
  const sizeMap = JSON.parse(window.sizeMap)
  const selectedSizes = $("select[name$='[shirt_size]']").toArray().map(e => $(e).val())
  selectedSizes.forEach(function(size) {
    if(size.length == 0) return
    const $field = $(`input[name$='[${sizeMap[size]}]']`)
    let count = parseInt($field.val()) || 0
    count += 1
    $field.val(count)
  })
}

