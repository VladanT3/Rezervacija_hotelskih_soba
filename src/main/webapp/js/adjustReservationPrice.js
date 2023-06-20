const checkBoxApplyPoints = document.getElementById("applyPoints");
const totalPriceElem = document.getElementById("reservationPrice");
let numberOfPoints = checkBoxApplyPoints.value;
let originalPrice = totalPriceElem.value;
let totalPrice;

checkBoxApplyPoints.addEventListener("change", function ()
{
    if(checkBoxApplyPoints.checked)
        totalPrice = originalPrice * (1 - numberOfPoints/100);
    else
        totalPrice = originalPrice;

    totalPrice = (Math.round(totalPrice * 100) / 100).toFixed(2);
    totalPriceElem.value = totalPrice;
});