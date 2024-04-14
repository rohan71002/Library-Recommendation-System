$(document).ready(function() {
	let email = sessionStorage.getItem("mail");		
	$('#logoutLink').click(function(event) {
        // Prevent default link behavior
        event.preventDefault();
        
        // Clear session storage
        sessionStorage.removeItem("mail");
        
        Swal.fire({
            title: "Logout Successfully",
            text: "Redirecting to Login Form...",
            icon: "success",
            showConfirmButton: true,
        }).then(function() {
            window.location.href = "../htmlFiles/Login.html"; // Change the URL as needed
        });
    });
         
        $.ajax({
        url: "../jspFiles/profile.jsp",
        method: "GET",
        dataType: "json",
        success: function(userData) {
			console.log("data",userData)
           let name = userData.name;
           console.log("data",userData.name)
           let phone = userData.phone;
            console.log("data",userData.phone)
           $("#name").val(name);
            $("#phone").val(phone);
            $("#email").val(email);
        },
        error: function(xhr, status, error) {
            console.error("Error fetching profile data:", error);
        }
    });
    
    $("#editbtn").click(function(event) {
    $("#name").prop("disabled", function(i, val) {
        var newState = !val;
        $("#editbtn").text(newState ? "Edit" : "No Edit");
        return newState;
    });
    $("#phone").prop("disabled", function(i, val) {
        return !val; // Toggle the disabled state
    });
});
        
});
