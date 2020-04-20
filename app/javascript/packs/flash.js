$(function () {
  $('.flash').hide().fadeIn(0, function () {
    setTimeout(function () {
      $('.flash').fadeOut(500)
    }, 3500);
  })
})


