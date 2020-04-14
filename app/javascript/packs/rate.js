$(function () {
  var $baseRate = $('#base_rate');
  var $targetRate = $('#target_rate');
  var $targetCurrency = $('#target_currency')
  var $calcRate = $('#calc_rate');
  // レートと通貨のjson
  var $rate_json = $('#rate_json').data('resource')

  

  //計算結果
  var baseRateResult = function ($targetRate, $calcRate) {
    return $baseRate.val(Math.round($targetRate.val() / $calcRate.val() * 1000) / 1000);
  };
  var targetRateResult = function ($baseRate, $calcRate) {
    return $targetRate.val(Math.round($baseRate.val() * $calcRate.val() * 1000) / 1000);
  };

  // ベースレート入力
  $baseRate.on('input', function () {
    targetRateResult($baseRate, $calcRate);
  });

  // ターゲットレート入力
  $targetRate.on('input', function () {
    baseRateResult($targetRate, $calcRate);
  });

  // return $result.val(Math.round($baseRate.val() * $targetRate.val() * 1000) / 1000)
  

  // ターゲット通貨セレクト
  $targetCurrency.change(function() {
    var selectedTargetCurrency = $targetCurrency.val();
    selectedTargetCurrencyRate = $rate_json[`${selectedTargetCurrency}`]
    $calcRate.val(selectedTargetCurrencyRate);
    targetRateResult($baseRate, $calcRate);
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

