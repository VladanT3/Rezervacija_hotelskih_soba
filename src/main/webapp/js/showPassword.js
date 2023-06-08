const showPassword = document.getElementById('showPassword');
const userPassword = document.getElementById('userPassword');

showPassword.addEventListener("change", function () {
    if (showPassword.checked)
        userPassword.type = 'text';
    else
        userPassword.type = 'password';
});