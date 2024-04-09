$(document).ready(function() {
	var email = sessionStorage.getItem("mail"); 
	let emailFirst=email.split('@');
	console.log(emailFirst[0])
	
	
	
        if (email) {
            document.getElementById("welcomeMessage").textContent = "Welcome, " + emailFirst[0];
        }
    var selectedItems = ""; // Declare selectedItems variable outside the event listener
        
  
    
    document.getElementById('filterForm').addEventListener('submit', function(event) {
        event.preventDefault();
        
        
        var selectElement = document.getElementById('genre');
        var selectedGenre = selectElement.options[selectElement.selectedIndex];
        var selectedGenreText = selectedGenre.text.trim();
        
        if (selectedGenre.value !== '') {
            selectElement.remove(selectedGenre.index);
            
            var selectedItemsContainer = document.getElementById('selectedItems');
            var selectedItemElement = document.createElement('div');
            selectedItemElement.textContent = selectedGenreText;
            selectedItemElement.classList.add('selected-item');
            
            var crossIcon = document.getElementById('crossIcon').cloneNode(true);
            
            crossIcon.addEventListener('click', function() {
                selectedItemsContainer.removeChild(selectedItemElement);
                
                var option = document.createElement('option');
                option.text = selectedGenreText;
                option.value = selectedGenre.value;
                selectElement.add(option);
            });
            
            selectedItemElement.appendChild(crossIcon);
            selectedItemsContainer.appendChild(selectedItemElement);
            
            // Update selectedItems value
            selectedItems = Array.from(selectedItemsContainer.children)
                .map(item => item.textContent.trim())
                .join(",");
            console.log("Selected Items: ", selectedItems);
        }
    });
    
    $("#submitbtn").click(function(event) {
        event.preventDefault();
        
        $.ajax({
            type: "POST",
            url: "../jspFiles/SurveyForm.jsp",
            data: { 
                genre: selectedItems
            },
           
            success: function(response) {
                console.log(response);
                let update=response.substring(0,6)
                console.log(update,"update");
                if(update === "update"){
				 Swal.fire({
                        title: "Updated Successsfully",
                        text: "Redirecting to Dashboard Page....",
                        icon: "success"
                    }).then(function() {
                        // Redirect to the login page
                        window.location.href = "../htmlFiles/Dashboard.html";
                    });
				}
                
            },
            error: function(xhr, status, error) {
                console.error(xhr.responseText);
                Swal.fire({
                    title: "Failed",
                    icon: "error"
                });
            }
        });
    });
});
