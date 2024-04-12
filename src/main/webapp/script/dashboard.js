

  $(document).ready(function() {
    let email = sessionStorage.getItem("mail"); 
    let emailFirst = email.split('@');
    console.log(emailFirst[0]);
    
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

    // Send a request to the backend to fetch the user's selected genre
    $.ajax({
        url: "../jspFiles/Dashboard.jsp",
        dataType: "json",
        success: function(userData) {
            //const selectedGenre = userData.genre;

            $.ajax({
                url: "../JSON/books.json",
                dataType: "json",
                success: function(data) {
                    const bookContainer = $("#bookContainer");
                    const selectedGenres = userData.genre.split(',');
                    selectedGenres.forEach(function(selectedGenre) {
                        data.books.forEach(book => {
                            // Check if the book's genre matches the user's selected genre
                            if (book.genre === selectedGenre) {
                                const bookCard = $("<div>").addClass("book-card");

                                const bookImage = $("<img>").attr({
                                    src: book.image,
                                    alt: book.title
                                }).addClass("book-image");
                                bookCard.append(bookImage);

                                const bookTitle = $("<div>").text(book.title).addClass("book-title");
                                bookCard.append(bookTitle);

                                const bookAuthor = $("<div>").text("Author: " + book.author).addClass("book-author");
                                bookCard.append(bookAuthor);

                                const bookGenre = $("<div>").text("Genre: " + book.genre).addClass("book-genre");
                                bookCard.append(bookGenre);

                                const bookDescription = $("<div>").text(book.description).addClass("book-description");
                                bookCard.append(bookDescription);

                                bookContainer.append(bookCard);
                            }
                        })
                        $('.book-description,.book-author').css('display', 'none');
                    });
                    

                    $('#searchInput').on('input', function() {
                        const searchQuery = $(this).val().toLowerCase();

                        $('.book-card').each(function() {
                            const bookTitle = $(this).find('.book-title').text().toLowerCase();
                            const bookAuthor = $(this).find('.book-author').text().toLowerCase();
                            const bookGenre = $(this).find('.book-genre').text().toLowerCase();
                            const bookDescription = $(this).find('.book-description').text().toLowerCase();

                            if (bookTitle.includes(searchQuery) || bookAuthor.includes(searchQuery) || bookGenre.includes(searchQuery) || bookDescription.includes(searchQuery)) {
                                $(this).show();
                            } else {
                                $(this).hide();
                            }
                        });
                    });

                    // Add click event listener to each book image to open modal
                    $('#bookContainer').on('click', '.book-image', function() {
						$('.book-container').css('opacity', '0.5');
						
			$('.modal,.close').click(function() {
			   $('.book-container').css('opacity', '100');
			});
			
			
                        const bookCard = $(this).closest('.book-card');
                        const book = {
                            title: bookCard.find('.book-title').text(),
                            author: bookCard.find('.book-author').text(),
                            genre: bookCard.find('.book-genre').text(),
                            description: bookCard.find('.book-description').text(),
                            image: bookCard.find('.book-image').attr('src')
                        };

                        // Populate the modal with the selected book's information
                        const bookDetailsModalBody = $('#bookDetailsModalBody');
                        bookDetailsModalBody.html(`
                            <div>
                            <h2>${book.title}</h2></>
                            
                            <p> ${book.author}</p>
                            <p>${book.genre}</p>
                            <p>Discription: ${book.description}</p>
                       </div>	 
                        <div>
                            <img src="${book.image}" height="160px" width="100px">
                            </div>
                        `
                        );

                        // Show the modal
                        $('#bookDetailsModal').modal('show');
                    });
                },
                error: function(error) {
                    console.error("Error fetching book data:", error);
                }
            });
        },
        error: function(error) {
            console.error("Error fetching user data:", error);
        }
    });
});
