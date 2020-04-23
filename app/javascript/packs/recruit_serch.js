// 国を選択すると自動で検索
$(function () {
  function searchCountry(pin, country) {
    $(pin).click(function () {
      $('#q_country_cont').val(country);
      $("form").find("button[type='submit']").click();
    });
  };

  $('#q_country_cont').change(function () {
    $("form").find("button[type='submit']").click();
  });
  searchCountry('.all_countries', '');
  searchCountry('.pin5', 'JP');
});

