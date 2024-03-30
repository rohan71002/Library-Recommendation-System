$(document).ready(function() {
    $("#submitbtn").click(function(event) {
        event.preventDefault();
        let name = $("#name").val();
        let phone = $("#phone").val();
        let email = $("#email").val();
        let pass = $("#pword").val();
        let cnfpass = $("#cnfpword").val();
        let Role = $("#role").val();

        console.log("name" + name);
        console.log("email" + email);
        console.log("pass" + pass);
        console.log("cnfpass" + cnfpass);
        console.log("Role" + Role);

        if (phone.length !== 10) {
            Swal.fire({
                title: "Error",
                text: "Phone Number invalid",
                icon: "error"
            });
            return; // Exit the function early if phone number is invalid
        } 

        if (pass.length < 8) {
            Swal.fire({
                title: "Error",
                text: "Password length must be greater than 8",
                icon: "error"
            });
            return; // Exit the function early if password length is less than 8
        } 

        if (pass !== cnfpass) {
            Swal.fire({
                title: "Error",
                text: "Passwords do not match",
                icon: "error"
            });
            return; // Exit the function early if passwords do not match
        }

        $.ajax({
            type: "POST",
            url: "../jspFiles/signup.jsp",
            data: { 
                name: name,
                pword: pass,
                cnfpword: cnfpass,
                phone: phone,
                email: email,
                role: Role
            },
            success: function(response) {
                console.log(response);
                let Success = response.substring(0, 7);
                console.log(Success);
                
                if (Success === "success") {
                    Swal.fire({
                        title: "Signup Successsfully",
                        text: "Redirecting to Login Page....",
                        icon: "success"
                    }).then(function() {
                        // Redirect to the login page
                        window.location.href = "../htmlFiles/Login.html";
                    });
                } else {
                    Swal.fire({
                        title: "Email already exist",
                        icon: "error"
                    });
                }
            },
            error: function(xhr, status, error) {
                console.error(xhr.responseText);
                Swal.fire({
                    title: "Failed to send OTP. Check Your Email",
                    icon: "error"
                });
            }
        });
    });
});
