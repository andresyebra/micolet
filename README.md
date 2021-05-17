# micolet
Micolet app was created to offer to the people interested in receiving our newsletter.

# Features
- Rails Version: 6.0.3
- Ruby Version: 2.7.0
- SQLite

# Structure
- App
    - controllers: Http actions
        - application_controller.rb
        - newsletters_controller.rb
    - models: Database models.
        - newsletter.rb
    - views: Application views.
        - layout
            - application.html.erb
        - newsletters
          - index.html.erb
          - new.html.erb
          - show.html.erb
- Config
    - routes.rb: Contain http routes.
    - database.yml: Configuration file for the database connection.
    - application.yml: Configuration file for the app.

# Setting up
1. Run migration to SQLite in development environment:  
   rails db:migrate RAILS_ENV=development

3. Run Rails server executing the command:  
   rails s -e development -p 3000
   
4. Enter to URL: http://localhost:3000/
