var form = document.getElementById('formID'); // form has to have ID: <form id="formID">
form.noValidate = true;
form.addEventListener('submit', function(event) { // listen for form submitting
    if (!event.target.checkValidity()){
        event.preventDefault();
        alert('Please answer all questions.'); // error message
    }
}, false);

