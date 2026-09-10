

document.querySelectorAll(".toggle-password").forEach((toggle) => {
  toggle.addEventListener("click", () => {
    const input = toggle.previousElementSibling;
    const icon = toggle.querySelector("i");
    const isPassword = input.type === "password";
    input.type = isPassword ? "text" : "password";
    icon.classList.toggle("fa-eye");
    icon.classList.toggle("fa-eye-slash");
  });
});

const form = document.querySelector('.register-form');
const fullnameInput = document.getElementById('fullname');
const emailInput = document.getElementById('email');
const passwordInput = document.getElementById('password');
const confirmPasswordInput = document.getElementById('confirm-password');
const termsCheckbox = document.getElementById('terms');

const showError = (input, message) => {
    const inputGroup = input.closest('.input-group') || input.parentElement;
    let errorDisplay = inputGroup.querySelector('.error-message');
    
    if (!errorDisplay) {
        errorDisplay = document.createElement('small');
        errorDisplay.className = 'error-message';
        errorDisplay.style.color = '#ff4d4d';
        errorDisplay.style.fontSize = '12px';
        errorDisplay.style.marginTop = '4px';
        errorDisplay.style.display = 'block';
        inputGroup.appendChild(errorDisplay);
    }
    errorDisplay.innerText = message;
    input.style.borderColor = '#ff4d4d';
};

const clearError = (input) => {
    const inputGroup = input.closest('.input-group') || input.parentElement;
    const errorDisplay = inputGroup.querySelector('.error-message');
    if (errorDisplay) {
        errorDisplay.remove();
    }
    input.style.borderColor = '';
};

const validateFullName = () => {
    const value = fullnameInput.value.trim();
    if (value.length < 2) {
        showError(fullnameInput, 'Name must be at least 2 characters long.');
        return false;
    }
    clearError(fullnameInput);
    return true;
};

const validateEmail = () => {
    const value = emailInput.value.trim();
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    
    if (!emailRegex.test(value)) {
        showError(emailInput, 'Please enter a valid email address.');
        return false;
    }
    clearError(emailInput);
    return true;
};

const validatePassword = () => {
    const value = passwordInput.value;
    const hasNumber = /\d/.test(value);
    const hasUppercase = /[A-Z]/.test(value);
    const hasSpecialChar = /[!@#$%^&*(),.?":{}|<>_]/.test(value);
    
    if (value.length < 8 || !hasNumber || !hasUppercase || !hasSpecialChar) {
        showError(passwordInput, 'Password must be 8+ characters with a number, uppercase letter, and special character.');
        return false;
    }
    clearError(passwordInput);
    return true;
};

const validateConfirmPassword = () => {
    if (confirmPasswordInput.value !== passwordInput.value) {
        showError(confirmPasswordInput, 'Passwords do not match.');
        return false;
    }
    clearError(confirmPasswordInput);
    return true;
};

const validateTerms = () => {
    if (!termsCheckbox.checked) {
        showError(termsCheckbox, 'You must agree to the Terms and Privacy Policy.');
        return false;
    }
    clearError(termsCheckbox);
    return true;
};

fullnameInput.addEventListener('blur', validateFullName);
emailInput.addEventListener('blur', validateEmail);
passwordInput.addEventListener('input', validatePassword);
confirmPasswordInput.addEventListener('input', validateConfirmPassword);
termsCheckbox.addEventListener('change', validateTerms);

form.addEventListener('submit', (event) => {
    const isNameValid = validateFullName();
    const isEmailValid = validateEmail();
    const isPasswordValid = validatePassword();
    const isConfirmValid = validateConfirmPassword();
    const isTermsValid = validateTerms();

    if (!isNameValid || !isEmailValid || !isPasswordValid || !isConfirmValid || !isTermsValid) {
        event.preventDefault(); 
    }
});
