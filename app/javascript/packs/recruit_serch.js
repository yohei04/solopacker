// 国を選択すると自動で検索
$(function () {
  $('#q_country_cont').change(function () {
    $("form").find("button[type='submit']").click();
  });
  $('.all_countries').click(function () {
    $('#q_country_cont').val('');
    $("form").find("button[type='submit']").click();
  })
  $('.pin5').click(function () {
    $('#q_country_cont').val("JP");
    $("form").find("button[type='submit']").click();
  })
});
