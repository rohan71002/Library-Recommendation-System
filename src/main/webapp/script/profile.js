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
			console.log("data",userData.role)
           let name = userData.name;
           let role = userData.role;
           let phone = userData.phone;
           $("#name").text(name);
            $("#email").text(email);
            $("#phone").text(phone);
            $("#role").text(role);
        },
        error: function(xhr, status, error) {
            console.error("Error fetching profile data:", error);
        }
    });
});/**
 * 
 */