# In this assignment, you'll be using the domain model from hw1 (found in the hw1-solution.sql file)
# to create the database structure for "KMDB" (the Kellogg Movie Database).
# The end product will be a report that prints the movies and the top-billed
# cast for each movie in the database.

# To run this file, run the following command at your terminal prompt:
# `rails runner kmdb.rb`

# Requirements/assumptions
#
# - There will only be three movies in the database – the three films
#   that make up Christopher Nolan's Batman trilogy.
# - Movie data includes the movie title, year released, MPAA rating,
#   and studio.
# - There are many studios, and each studio produces many movies, but
#   a movie belongs to a single studio.
# - An actor can be in multiple movies.
# - Everything you need to do in this assignment is marked with TODO!

# Rubric
# 
# There are three deliverables for this assignment, all delivered within
# this repository and submitted via GitHub and Canvas:
# - Generate the models and migration files to match the domain model from hw1.
#   Table and columns should match the domain model. Execute the migration
#   files to create the tables in the database. (5 points)
# - Insert the "Batman" sample data using ruby code. Do not use hard-coded ids.
#   Delete any existing data beforehand so that each run of this script does not
#   create duplicate data. (5 points)
# - Query the data and loop through the results to display output similar to the
#   sample "report" below. (10 points)

# Submission
# 
# - "Use this template" to create a brand-new "hw2" repository in your
#   personal GitHub account, e.g. https://github.com/<USERNAME>/hw2
# - Do the assignment, committing and syncing often
# - When done, commit and sync a final time before submitting the GitHub
#   URL for the finished "hw2" repository as the "Website URL" for the 
#   Homework 2 assignment in Canvas

# Successful sample output is as shown:

# Movies
# ======

# Batman Begins          2005           PG-13  Warner Bros.
# The Dark Knight        2008           PG-13  Warner Bros.
# The Dark Knight Rises  2012           PG-13  Warner Bros.

# Top Cast
# ========

# Batman Begins          Christian Bale        Bruce Wayne
# Batman Begins          Michael Caine         Alfred
# Batman Begins          Liam Neeson           Ra's Al Ghul
# Batman Begins          Katie Holmes          Rachel Dawes
# Batman Begins          Gary Oldman           Commissioner Gordon
# The Dark Knight        Christian Bale        Bruce Wayne
# The Dark Knight        Heath Ledger          Joker
# The Dark Knight        Aaron Eckhart         Harvey Dent
# The Dark Knight        Michael Caine         Alfred
# The Dark Knight        Maggie Gyllenhaal     Rachel Dawes
# The Dark Knight Rises  Christian Bale        Bruce Wayne
# The Dark Knight Rises  Gary Oldman           Commissioner Gordon
# The Dark Knight Rises  Tom Hardy             Bane
# The Dark Knight Rises  Joseph Gordon-Levitt  John Blake
# The Dark Knight Rises  Anne Hathaway         Selina Kyle

# Delete existing data, so you'll start fresh each time this script is run.
# Use `Model.destroy_all` code.
# TODO!
Studio.destroy_all
Movie.destroy_all
Actor.destroy_all
Role.destroy_all

# Generate models and tables, according to the domain model.
# TODO!

# Insert data into the database that reflects the sample data shown above.
# Do not use hard-coded foreign key IDs.
# TODO!

# - insert data into studios table
studio = Studio.new
studio["name"] = "Warner Bros."
studio.save

# - insert data into movies table
warner = Studio.find_by({"name" => "Warner Bros."})

movie = Movie.new
movie["title"] = "Batman Begins"
movie["year_released"] = 2005
movie["rated"] = "PG-13"
movie["studio_id"] = warner["id"]
movie.save

movie = Movie.new
movie["title"] = "The Dark Knight"
movie["year_released"] = 2008
movie["rated"] = "PG-13"
movie["studio_id"] = warner["id"]
movie.save

movie = Movie.new
movie["title"] = "The Dark Knight Rises"
movie["year_released"] = 2012
movie["rated"] = "PG-13"
movie["studio_id"] = warner["id"]
movie.save


# - insert data into actors table
actor_list = ["Christian Bale", "Michael Caine", "Liam Neeson", 
"Katie Holmes","Gary Oldman","Heath Ledger","Aaron Eckhart",
"Maggie Gyllenhaal","Tom Hardy","Joseph Gordon-Levitt","Anne Hathaway"]

for actor in actor_list
    actor_new = Actor.new
    actor_new["name"] = actor
    actor_new.save
end

# - insert data into roles table

# -- Batman Begins
actors = ["Christian Bale", "Michael Caine", "Liam Neeson", 
"Katie Holmes","Gary Oldman"]

roles = ["Bruce Wayne","Alfred","Ra's Al Ghul","Rachel Dawes",
"Commissioner Gordon"]
index = 0
for actor in actors
    role_new = Role.new
    role_new["movie_id"] = Movie.find_by({"title" => "Batman Begins"})["id"]
    role_new["actor_id"] = Actor.find_by({"name" => actor})["id"]
    role_new["character_name"] = roles[index]
    role_new.save
    index = index + 1
end    

# -- The Dark Knight
actors = ["Christian Bale", "Heath Ledger", "Aaron Eckhart", 
"Michael Caine","Maggie Gyllenhaal"]

roles = ["Bruce Wayne","Joker","Harvey Dent","Alfred",
"Rachel Dawes"]
index = 0
for actor in actors
    role_new = Role.new
    role_new["movie_id"] = Movie.find_by({"title" => "The Dark Knight"})["id"]
    role_new["actor_id"] = Actor.find_by({"name" => actor})["id"]
    role_new["character_name"] = roles[index]
    role_new.save
    index = index + 1
end    

# -- The Dark Knight Rises
actors = ["Christian Bale", "Gary Oldman", "Tom Hardy", 
"Joseph Gordon-Levitt","Anne Hathaway"]

roles = ["Bruce Wayne","Commissioner Gordon","Bane","John Blake",
"Selina Kyle"]
index = 0
for actor in actors
    role_new = Role.new
    role_new["movie_id"] = Movie.find_by({"title" => "The Dark Knight Rises"})["id"]
    role_new["actor_id"] = Actor.find_by({"name" => actor})["id"]
    role_new["character_name"] = roles[index]
    role_new.save
    index = index + 1
end    

# Prints a header for the movies output
puts "Movies"
puts "======"
puts ""

# Query the movies data and loop through the results to display the movies output.
# TODO!
movie_list = Movie.all
for movie in movie_list
    title = movie["title"]
    year = movie["year_released"]
    rated = movie["rated"]
    studio = Studio.find_by({"id" => movie["studio_id"]})["name"]
    puts "%-25s %-6d %-8s %s" % [title, year, rated, studio]
end


# Prints a header for the cast output
puts ""
puts "Top Cast"
puts "========"
puts ""

# Query the cast data and loop through the results to display the cast output for each movie.
# TODO!
role_list = Role.all
for role in role_list
    movie = Movie.find_by({"id" => role["movie_id"]})["title"]
    actor = Actor.find_by({"id" => role["actor_id"]})["name"]
    character = role["character_name"]
    puts "%-25s %-25s %-25s" % [movie, actor, character]
end