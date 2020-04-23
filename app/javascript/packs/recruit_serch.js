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
  searchCountry('.pin6', gon.current_user_origin);
  searchCountry('.pin1', gon.first_popular_country);
  console.log(gon.first_popular_country)
});

