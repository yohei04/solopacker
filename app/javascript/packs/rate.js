$(function () {
  // レートと通貨のjson
  const $rate_json = $('#rate_json').data('resource')
  // レート機能全体の関数
  const rating = function ($inputBaseRate, $baseCurrency, $inputTargetRate, $targetCurrency,
                            $baseRate, $targetRate) {
    //入力値とレートから計算結果を算出する関数
    var inputBaseRateResult = function ($inputTargetRate, $baseRate, $targetRate) {
      $inputBaseRate.val(Math.round($inputTargetRate.val() * $baseRate.val() / $targetRate.val() * 100) / 100);
    };
    var inputTargetRateResult = function ($inputBaseRate, $baseRate, $targetRate) {
      $inputTargetRate.val(Math.round($inputBaseRate.val() / $baseRate.val() * $targetRate.val() * 100) / 100);
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

  // 複数の計算に対応
  for (var i = 0; i < 5; i++) {
    var $inputBaseRate = $(`#input_base_rate-${i}`);
    var $baseCurrency = $(`#base_currency-${i}`)
    var $inputTargetRate = $(`#input_target_rate-${i}`);
    var $targetCurrency = $(`#target_currency-${i}`)
    var $baseRate = $(`#base_rate-${i}`);
    var $targetRate = $(`#target_rate-${i}`);
    rating($inputBaseRate, $baseCurrency, $inputTargetRate, $targetCurrency, $baseRate, $targetRate);
  };
});
