# README
XYZ Books by Marjy Galingan

* Ruby version = 3.2.2
* Rails version = 7.0.4
* System dependencies = none
* Configuration
* 
    `config/environments/development.rb`
    added `config.log_level = :warn` to minimize logs
* Database = SQLite
  ![image](https://github.com/Alcafam/xyz_books/assets/90877974/08823d75-cc9b-404a-b337-43f62495f8e3)
  In terminal:
```
rails c
// Book table
Book.create(title: "American Elf", isbn_13: "978-1-891830-85-3", isbn_10: "1-891-83085-6", price: 0.1e4, year_published: 2004, image: "9781891830853.jpg", edition: "Book 2", publisher_id: 1)
Book.create(title: "Cosmoknights", isbn_13: "978-1-60309-454-2", isbn_10: "1-603-09454-7", price: 0.2e4, year_published: 2019, image: "9781603094542.jpg", edition: "Book 1", publisher_id: 2)
Book.create(title: "Essex County", isbn_13: "978-1-60309-038-4", isbn_10: "1-603-09038-X", price: 0.5e3, year_published: 1990, image: "9781603090384.jpg", publisher_id: 3)
Book.create(title: "Hey, Mister (Vol 1)", isbn_13: "978-1-891830-02-0", isbn_10: "1-891-83002-3", price: 0.12e4, year_published: 2000, image: "9781891830020.jpg", edition: "After School Special", publisher_id: 3)
Book.create(title: "The Underwater Welder", isbn_13: "978-1-60309-398-9", isbn_10: "1-603-09398-2", price: 0.3e4, year_published: 2022, image: "9781603093989.png", publisher_id: 4)

// Author Table
Author.create(first_name: "Joel", last_name: "Hartse")
Author.create(first_name: "Hannah", last_name: "Templer",middle_initial: "P")
Author.create(first_name: "Marguerite", last_name: "Duras",middle_initial: "Z")
Author.create(first_name: "Kingsley", last_name: "Amis")
Author.create(first_name: "Fannie", last_name: "Flagg",middle_initial: "Peters")
Author.create(first_name: "Camille", last_name: "Paglia",middle_initial: "Byron")
Author.create(first_name: "Rainer", last_name: "Rilke",middle_initial: "Steel")

//Publisher Table
Publisher.create(name: "Paste Magazine")
Publisher.create(name: "Publishers Weekly")
Publisher.create(name: "Graywolf Press")
Publisher.create(name: "Mc Sweeney's")

// AuthorBook Table
AuthorBook.create(author_id: 1,book_id:1)
AuthorBook.create(author_id: 2,book_id:1)
AuthorBook.create(author_id: 3,book_id:1)
AuthorBook.create(author_id: 4,book_id:2)
AuthorBook.create(author_id: 4,book_id:3)
AuthorBook.create(author_id: 2,book_id:4)
AuthorBook.create(author_id: 5,book_id:4)
AuthorBook.create(author_id: 6,book_id:4)
AuthorBook.create(author_id: 7,book_id:5)
```

* HOW TO RUN THE WEBSITE
* 
      - bundle update
      - rails s
      -open given link in browser
  
* HOW TO RUN THE TEST SUITE
* 
    Test Cases uses Rspec
    The file tested is in the spec directory:
        ```spec > models >book_spec```
    run `rspec #{book_spec_directory}`
