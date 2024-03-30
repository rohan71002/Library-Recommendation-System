$(document).ready(function() {
	
    $("#loginbtn").click(function() {
		let email=$("#email").val();
	let pass=$("#password").val();
	console.log(email+pass)
        // Prevent the default form submission
        event.preventDefault();

        // Get the form data
if (email==""){
	Swal.fire({
                        title: "email can not be empty",
                        icon: "error",
                        showConfirmButton: true,
                    });
                    return;
}
else if (pass===""){
	Swal.fire({
                        title: "password can not be empty",
                        icon: "error",
                        showConfirmButton: true,
                    });
                     return;
}
        // Send an AJAX request to the servlet
        $.ajax({
            type: "POST",
            url: "../jspFiles/login.jsp", // Change the URL to match your servlet mapping
            data: { mail: email,
            pass:pass},
            success: function(response) {
				console.log(response)
				success=response.substring(0,7);
				console.log(success)
                if (success === "success") {
                    Swal.fire({
                        title: "Login Successfully",
                        text:"Redirecting to Dashboard...",
                        icon: "success",
                        showConfirmButton: true,
                    }).then(()=>{
						window.location.href="../htmlFiles/signup.html"
					})
                } else {
                   Swal.fire({
                        title: "Incorrect email or password",
                        icon: "error",
                        showConfirmButton: true,
                    });
            }},
            error: function(xhr, status, error) {
                console.error("Error:", error);
                // Handle the error, such as displaying an error message
                $("#loginError").text("An error occurred while processing your request.");
            }
        });
    });
});
