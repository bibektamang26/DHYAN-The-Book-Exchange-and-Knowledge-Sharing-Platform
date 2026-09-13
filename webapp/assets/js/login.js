



const form = document.querySelector('.login-form');
const emailInput = document.getElementById('email');
const passwordInput = document.getElementById('password');
const togglePasswordIcon = document.querySelector('.toggle-password');

if (togglePasswordIcon) {
    togglePasswordIcon.addEventListener('click', () => {
        const icon = togglePasswordIcon.querySelector('i');
        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            icon.classList.replace('fa-eye', 'fa-eye-slash');
        } else {
            passwordInput.type = 'password';
            icon.classList.replace('fa-eye-slash', 'fa-eye');
        }
    });
}

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
    
    if (value.length === 0) {
        showError(passwordInput, 'Password cannot be empty.');
        return false;
    }
    clearError(passwordInput);
    return true;
};

emailInput.addEventListener('blur', validateEmail);
passwordInput.addEventListener('blur', validatePassword);

form.addEventListener('submit', (event) => {
    const isEmailValid = validateEmail();
    const isPasswordValid = validatePassword();

    if (!isEmailValid || !isPasswordValid) {
        event.preventDefault(); 
    }
});


window.onload = function () {
    google.accounts.id.initialize({
        client_id: "469510402526-q0cn4tt98sjui7f3uq9c4imr4e22ldp3.apps.googleusercontent.com",
        ux_mode: "redirect",
        login_uri: "http://localhost:8080/DHYAN/google-login" 
    });

    const googleBtnContainer = document.getElementById('googleBtnContainer');
    if (googleBtnContainer) {
        google.accounts.id.renderButton(
            googleBtnContainer,
            { 
                type: "standard",
                shape: "rectangular",
                theme: "outline",
                text: "signin_with",
                size: "large",
                logo_alignment: "center",
                locale: "en",      
                width: 350          
            }
        );
    }
};
