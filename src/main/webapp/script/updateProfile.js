$(document).ready(function() {
    let email = sessionStorage.getItem("mail");
    let initialName, initialPhone;

    $('#logoutLink').click(function(event) {
        event.preventDefault();
        sessionStorage.removeItem("mail");
        Swal.fire({
            title: "Logout Successfully",
            text: "Redirecting to Login Form...",
            icon: "success",
            showConfirmButton: true,
        }).then(function() {
            window.location.href = "../htmlFiles/Login.html";
        });
    });

    $.ajax({
        url: "../jspFiles/profile.jsp",
        method: "GET",
        dataType: "json",
        success: function(userData) {
            let name = userData.name;
            let phone = userData.phone;
            $("#name").val(name);
            $("#phone").val(phone);
            $("#email").val(email);
            
             initialName = name;
            initialPhone = phone;
        },
        error: function(xhr, status, error) {
            console.error("Error fetching profile data:", error);
        }
    });

    // Initially disable the submit button
    $("#submitbtn").prop("disabled", true);

    $("#editbtn").click(function(event) {
		if ($("#editbtn").text() === "Discard") {
            $("#name").val(initialName);
            $("#phone").val(initialPhone);
        }
        $("#name").prop("disabled", function(i, val) {
            newState = !val;
            $("#editbtn").text(newState ? "Edit" : "Discard");
            return newState;
        });
        $("#phone").prop("disabled", function(i, val) {
            return !val; // Toggle the disabled state
        });

        // Enable the submit button
        $("#submitbtn").prop("disabled", false).css("cursor", "pointer");
         
    });

    $("#submitbtn").click(function(event) {
        let name = $('#name').val();
        let phone = $('#phone').val();
        event.preventDefault();
        $.ajax({
            type: "POST",
            url: "../jspFiles/updateProfile.jsp",
            data: {
                name: name,
                phone: phone
            },
            success: function(response) {
                console.log(response)
                let change = response.substring(0, 6);
                if (change === "change") {
                    Swal.fire({
                        title: "Updated Successfully",
                        text: "Redirecting to Dashboard Page....",
                        icon: "success"
                    }).then(function() {
                        window.location.href = "../htmlFiles/Dashboard.html";
                    });
                }
            },
            error: function(xhr, status, error) {
                console.error(error);
                Swal.fire({
                    title: "Failed",
                    icon: "error"
                });
            }
        });
    });

});
