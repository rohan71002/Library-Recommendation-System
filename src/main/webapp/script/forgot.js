$(document).ready(function() {
	$("#sendOTP").prop("disabled", true).css("background-color", "#666").css("cursor", "not-allowed");
	
	$("#mail").on("input", function() {
        if ($(this).val().trim() !== "") {
            $("#sendOTP").prop("disabled", false).css("background-color", "#8b4513").css("cursor", "pointer");
        } else {
            $("#sendOTP").prop("disabled", true).css("background-color", "#666").css("cursor", "not-allowed");
        }
    });
	$("#verifyOTP").prop("disabled", true).css("background-color", "#666").css("cursor", "not-allowed");
	
	$("#otp").on("input", function() {
        if ($(this).val().trim() !== "") {
            $("#verifyOTP").prop("disabled", false).css("background-color", "#8b4513").css("cursor", "pointer");
        } else {
            $("#verifyOTP").prop("disabled", true).css("background-color", "#666").css("cursor", "not-allowed");
        }
    });
	
    $("#sendOTP").click(function() {
        event.preventDefault();
        var recipient = $("#mail").val();
        // AJAX request to send OTP
        Swal.fire({
                        title: "Please Wait ",
                        icon: "success",
                        showConfirmButton: false,
                        timer: 1000
                    });
        $.ajax({
            type: "POST",
            url: "../jspFiles/forgot.jsp",
            data: { mail: recipient },
            success: function(response) {
            	console.log(response)
            	tresresult=response.substring(0,11);
            	console.log(tresresult)
            	
                if (tresresult === "EmailExists") {
                    Swal.fire({
                        title: "Failed to send OTP Check Your Email",
                        icon: "error"
                    });
                }
            	else{
            	Swal.fire({
            		  title: "OTP Sent SuccessFully",
            		  icon: "success"
            		}).then(()=>
            		{
            			// Disable the button and change its color to dark grey
            			$("#sendOTP").prop("disabled", true).css("background-color", "#666").css("cursor", "not-allowed");

            			// Set a timeout to enable the button after 3 seconds (for example)
            			setTimeout(function() {
            			    $("#sendOTP").prop("disabled", false).css("background-color", "#8b4513").css("cursor", "pointer"); // Enable the button and revert its color
            			}, 30000); // 3000 milliseconds = 3 seconds
         		});
            }},
            error: function(xhr, status, error) {
                //console.log(xhr.responseText);
                Swal.fire({
          		  title: "Failed to send OTP Check Your Email",
          		  icon: "error"
          		});
            }
        });
    });
});



$(document).ready(function() {
$("#verifyOTP").click(function(event) {
    event.preventDefault();
    let enteredOTP = $("#otp").val();
    let recipient = $("#mail").val();
    console.log(enteredOTP,"ottttttttp"); // Retrieve the value from the OTP input field
    // AJAX request to verify OTP
    Swal.fire({
        title: "Please Wait",
        icon: "success",
        showConfirmButton: false,
        timer: 1000
    });
    $.ajax({
        type: "POST",
        url: "../jspFiles/verifyOTP.jsp",
        data: { otp: enteredOTP,
        mail: recipient
         },
        success: function(response) {
            console.log(response);
            incorrectotp=response.substring(0,12)
            if(incorrectotp==="IncorrectOTP"){
				Swal.fire({
                        title: "Wrong OTP",
                        icon: "error"
                    });
			}
			else{
			swal.fire({
    title: "OTP verified Successfully",
    text: "Your password has been sent to your registered email. Redirecting to Login page...",
    icon: "success"
}).then(() => {
    window.location.href = "../htmlFiles/Login.html";
});            
        }},
        error: function(xhr, status, error) {
            console.log(xhr.responseText);
            Swal.fire({
                title: "Failed to verify OTP",
                icon: "error"
            });
        }
    });
});
});