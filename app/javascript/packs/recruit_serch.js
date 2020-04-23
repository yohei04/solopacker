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
  searchCountry('.first_popular_country', gon.popular_countries[0]);
  searchCountry('.second_popular_country', gon.popular_countries[1]);
  searchCountry('.third_popular_country', gon.popular_countries[2]);
  searchCountry('.next_country', gon.next_country);
  searchCountry('.origin', gon.current_user_origin);
  console.log(gon.first_popular_country)
});

