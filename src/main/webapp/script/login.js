$(document).ready(function() {
	

    $("#loginbtn").click(function(event) {
        // Prevent the default form submission
        event.preventDefault();

        // Get the email and password from the input fields
        let email = $("#email").val().trim();
        let pass = $("#password").val();

sessionStorage.setItem('mail', email);
        // Validate email and password
        if (email === "") {
            Swal.fire({
                title: "Email cannot be empty",
                icon: "error",
                showConfirmButton: true,
            });
            return;
        } else if (pass === "") {
            Swal.fire({
                title: "Password cannot be empty",
                icon: "error",
                showConfirmButton: true,
            });
            return;
        }

        // Send an AJAX request to the server
        $.ajax({
            type: "POST",
            url: "../jspFiles/login.jsp", // Change the URL to match your servlet mapping
            data: {
                mail: email,
                pass: pass
            },
            success: function(response) {
                console.log(response);
                survey=response.substring(0,6);
                // Check the response from the server
                if (survey === "survey") {
                    // If login is successful, redirect to dashboard
                    Swal.fire({
                        title: "Login Successful",
                        text: "Redirecting to Survey Form...",
                        icon: "success",
                        showConfirmButton: true,
                    }).then(function() {
                        window.location.href = "../htmlFiles/surveyForm.html"; // Change the URL as needed
                    });
                }  else if(survey === "Survey") {
                    
                    Swal.fire({
                        title: "Login Successful",
                        text: "Redirecting to Dashboard...",
                        icon: "success",
                        showConfirmButton: true,
                    }).then(function() {
                        window.location.href = "../htmlFiles/Dashboard.html"; // Change the URL as needed
                    });
                }
                else{
					Swal.fire({
                        title: "Incorrect Email or Password",
                        icon: "error",
                        showConfirmButton: true,
                    });
				}
            },
            error: function(xhr, status, error) {
                console.error("Error:", error);
                // Handle the error, such as displaying an error message
                Swal.fire({
                    title: "An error occurred",
                    text: "Please try again later.",
                    icon: "error",
                    showConfirmButton: true,
                });
            }
        });
    });
});
