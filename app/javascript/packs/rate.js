$(function () {
  // レートと通貨のjson
  const $rate_json = $('#rate_json').data('resource')
  // レート機能全体の関数
  const rating = function ($inputBaseRate, $baseCurrency, $inputTargetRate, $targetCurrency,
                            $baseRate, $targetRate) {
    //入力値とレートから計算結果を算出する関数
    var inputBaseRateResult = function ($inputTargetRate, $baseRate, $targetRate) {
      return $inputBaseRate.val(Math.round($inputTargetRate.val() * $baseRate.val() / $targetRate.val() * 1000) / 1000);
    };
    var inputTargetRateResult = function ($inputBaseRate, $baseRate, $targetRate) {
      return $inputTargetRate.val(Math.round($inputBaseRate.val() / $baseRate.val() * $targetRate.val() * 1000) / 1000);
    };
  
    // ベースレート入力
    $inputBaseRate.on('input', function () {
      inputTargetRateResult($inputBaseRate, $baseRate, $targetRate);
    });
  
    // ターゲットレート入力
    $inputTargetRate.on('input', function () {
      inputBaseRateResult($inputTargetRate, $baseRate, $targetRate);
    });
  
    // ベース通貨セレクト
    $baseCurrency.change(function () {
      var selectedBaseCurrency = $baseCurrency.val();
      selectedBaseCurrencyRate = $rate_json[`${selectedBaseCurrency}`]
      $baseRate.val(selectedBaseCurrencyRate);
      inputTargetRateResult($inputBaseRate, $baseRate, $targetRate);
    });
  
    // ターゲット通貨セレクト
    $targetCurrency.change(function() {
      var selectedTargetCurrency = $targetCurrency.val();
      selectedTargetCurrencyRate = $rate_json[`${selectedTargetCurrency}`]
      $targetRate.val(selectedTargetCurrencyRate);
      inputBaseRateResult($inputTargetRate, $baseRate, $targetRate);
    });
  };

  // current country
  var $inputBaseRate = $('#input_base_rate');
  var $baseCurrency = $('#base_currency')
  var $inputTargetRate = $('#input_target_rate');
  var $targetCurrency = $('#target_currency')
  var $baseRate = $('#base_rate');
  var $targetRate = $('#target_rate');
  rating($inputBaseRate, $baseCurrency, $inputTargetRate, $targetCurrency, $baseRate, $targetRate);

  // next recruit
  var $inputBaseRate = $('#input_base_rate_recruit');
  var $baseCurrency = $('#base_currency_recruit')
  var $inputTargetRate = $('#input_target_rate_recruit');
  var $targetCurrency = $('#target_currency_recruit')
  var $baseRate = $('#base_rate_recruit');
  var $targetRate = $('#target_rate_recruit');
  rating($inputBaseRate, $baseCurrency, $inputTargetRate, $targetCurrency, $baseRate, $targetRate);
});
