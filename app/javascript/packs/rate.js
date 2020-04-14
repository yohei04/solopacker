$(function () {
  var $inputBaseRate = $('#input_base_rate');
  var $baseCurrency = $('#base_currency')
  var $inputTargetRate = $('#input_target_rate');
  var $targetCurrency = $('#target_currency')
  var $baseRate = $('#base_rate');
  var $targetRate = $('#target_rate');
  // レートと通貨のjson
  var $rate_json = $('#rate_json').data('resource')

  

  //計算結果
  var inputBaseRateResult = function ($inputTargetRate, $targetRate) {
    return $inputBaseRate.val(Math.round($inputTargetRate.val() / $targetRate.val() * 1000) / 1000);
  };
  var inputTargetRateResult = function ($inputBaseRate, $targetRate) {
    return $inputTargetRate.val(Math.round($inputBaseRate.val() * $targetRate.val() * 1000) / 1000);
  };

  // ベースレート入力
  $inputBaseRate.on('input', function () {
    inputTargetRateResult($inputBaseRate, $targetRate);
  });

  // ターゲットレート入力
  $inputTargetRate.on('input', function () {
    inputBaseRateResult($inputTargetRate, $targetRate);
  });

  // return $result.val(Math.round($baseRate.val() * $targetRate.val() * 1000) / 1000)
  

  // ターゲット通貨セレクト
  $targetCurrency.change(function() {
    var selectedTargetCurrency = $targetCurrency.val();
    selectedTargetCurrencyRate = $rate_json[`${selectedTargetCurrency}`]
    $targetRate.val(selectedTargetCurrencyRate);
    inputTargetRateResult($inputBaseRate, $targetRate);
  });

  // ターゲット通貨セレクト
  $baseCurrency.change(function() {
    var selectedBaseCurrency = $baseCurrency.val();
    selectedBaseCurrencyRate = $rate_json[`${selectedBaseCurrency}`]
    $baseRate.val(selectedBaseCurrencyRate);
    inputBaseRateResult($inputBaseRate, $targetRate);
  });
});



// let baseRate = document.getElementById("base_rate");
// let targetRate = document.getElementById("target_rate");


// console.log(baseRate)
// console.log(baseRate)

// function OnButtonClick() {
//   target = document.getElementById("output");
//   target.innerHTML = "Penguin";
// }

// document.getElementById("button").onclick = function () {
//   document.getElementById("target_rate").value = document.getElementById("base_rate").value * targetRate.value
//   // document.getElementById("output").innerHTML = document.getElementById("base_rate").value * targetRate.value
  
// };

