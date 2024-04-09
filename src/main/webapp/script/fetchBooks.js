// fetchBooks.js
fetch('https://freetestapi.com/api/v1/books')
    .then(response => response.json())
    .then(data => {
        const booksList = document.getElementById('books-list');
        data.forEach(book => {
            const bookElement = document.createElement('div');
            bookElement.innerHTML = `
                <h3>${book.title}</h3>
                <p><b>Author:</b> ${book.author}</p>
                <p><b>Genre: </b>${book.genre}</p>
                <p><b>Year: </b>${book.publication_year}</p>
                <img src="../Images/Bookish1-300x450.webp">
            `;
            booksList.appendChild(bookElement);
        });
    })
    .catch(error => console.error('Error fetching books:', error));
/**
 * 
 */