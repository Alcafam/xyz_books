# README
XYZ Books by Marjy Galingan

* Ruby version = 3.2.2
* Rails version = 7.0.4
* System dependencies = none
* Configuration
    `config/environments/development.rb`
    added `config.log_level = :warn` to minimize logs
* Database = SQLite
  ![image](https://github.com/Alcafam/xyz_books/assets/90877974/08823d75-cc9b-404a-b337-43f62495f8e3)

* HOW TO RUN THE WEBSITE
      -`rails s`
      -open given link in browser
  
* HOW TO RUN THE TEST SUITE
    Test Cases uses Rspec
    The file tested is in the spec directory:
        ```
        -spec
            - models
                -book_spec
        ```
    run `rspec #{book_spec_directory}`
