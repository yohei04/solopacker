// 国を選択すると自動で検索
$(function () {
  $('#q_country_cont').change(function () {
    $("form").find("button[type='submit']").click();
  });
});

