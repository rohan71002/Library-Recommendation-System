$(document).ready(function() {
    $("#myform").submit(function() {
        event.preventDefault();
        var formData = {
            name: $("#name").val(),
            email: $("#email").val(),
            password: $("#pword").val(),
            phone: $("#phone").val(),
            role: $("#role").val()
        };
        
        // Send AJAX request to signup.jsp
        $.ajax({
            type: "POST",
            url: "signup.jsp",
            data: formData,
            dataType: "json",
            success: function(response) {
                if(response.success) {
                    // Show success message
                    Swal.fire({
                        title: 'Success',
                        text: 'Account created successfully!',
                        icon: 'success',
                        confirmButtonText: 'OK'
                    }).then(() => {
                        // Redirect to login page
                        window.location.href = '../htmlFiles/Login.html';
                    });
                } else {
                    // Show error message
                    Swal.fire({
                        title: 'Error',
                        text: 'User with this email already exists!',
                        icon: 'error',
                        confirmButtonText: 'OK'
                    });
                }
            },
            error: function(xhr, status, error) {
                console.error(xhr.responseText);
                // Show error message
                Swal.fire({
                    title: 'Error',
                    text: 'An error occurred while processing your request. Please try again later.',
                    icon: 'error',
                    confirmButtonText: 'OK'
                });
            }
        });
    });
});
function check() {
    let pass = document.getElementById("pword");
    let cnfpass = document.getElementById("cnfpword");
    let phone = document.getElementById("phone");
    let choose = document.getElementById("role")
console.log(phone.value.length);
var emailInput = document.getElementById('email');
var emailPattern = /^[a-zA-Z0-9]+[._%+-]?[a-zA-Z0-9]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        

    if (phone.value.length !== 10) 
    {
		
        Swal.fire({
  title: "Error",
  text: "Phone Number invalid",
  icon: "error"
});
        event.preventDefault();	
    } 
    else if (pass.value.length < 8) 
    {
		
        Swal.fire({
  title: "Error",
  text: "Password length must be greater than 8",
  icon: "error"
});
        event.preventDefault();
    } 
    else if (pass.value !== cnfpass.value) 
    {
        Swal.fire({
  title: "Error",
  text: "Passwords do not match",
  icon: "error"
});
        event.preventDefault();
    }
    else if (!emailPattern.test(emailInput.value)) {
                event.preventDefault();
                Swal.fire({
                    title: "Email Format invalid",
                    icon:'error',
                  })
            } 
}

