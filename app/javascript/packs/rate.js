$(function () {
  var $baseRate = $('#base_rate');
  var $targetRate = $('#target_rate');
  var $result = $('#result');
  var $rate_json = $('#rate_json').data('resource')
  console.log($rate_json["JPY"])
  $result.val($baseRate.val() * $targetRate.val())
  $baseRate.on('input', function (event) {
    var value = $baseRate.val();
    $result.val(Math.round(value * $targetRate.val() * 1000) / 1000);
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

