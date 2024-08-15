# README
Weblog (Small Social Media)

## Overview
An application you can CRUD (create, read, uodate, destroy) via API HTTP request.
you can post a topic with content and can comment in the application.

* Ruby version
ruby 3.3.4

* System dependencies
Rails 7.2.0

## Setup Instructions
* Clone the repository
    run
        git clone https://github.com/pumachaya/weblogTesting.git
        cd weblogTesting

* Install Dependencies
    run
        bundle install

* Configure Environment Variables
    create .env on the root of the project with a content of
        API_TOKEN=9999 (or your desire value)

* Database initialization
    run
        rails db:create
        rails db:migrate

## How to start the server
    run
        ruby bin/rails server
    
    if you want to see a webpage on browser you can directly paste with
        http://127.0.0.1:3000/
        (with request headers: key=Authorization, value=9999 (or your desire value you've set on API_TOKEN))

## How to run tests
    On the root of the project run
        bundle exec rspec

## API endpoints with request and response examples.
    (all method shold be include request headers: key=Authorization, value=9999 (or your desire value you've set on API_TOKEN))

    for posts
        GET /main/(posts_id)    (add more request headers: key=Accept, value=application/json)
        Example:    GET http://localhost:3000/main/1
        Response:   {
                        "id": 1,
                        "title": "How do you love someone?",
                        "body": "I've never been in love before",
                        "author": "Chayanis",
                        "created_at": "2024-08-11T11:50:54.087Z",
                        "updated_at": "2024-08-13T13:49:48.756Z"
                    }

        POST /main/
        Example:    POST http://localhost:3000/main
        Body:       {
                        "post" : {
                            "title": "What brand has the best bacon",
                            "body": "I've wandering the store nearby, and all are expensive.",
                            "author": "Mimi"
                        }
                    }

        PUT /main/(posts_id)
        Example:    PUT http://localhost:3000/main/8
        Body:       {
                        "post" : {
                            "title": "What plant should I plant in a bedroom?",
                            "body": "please help me find a good one",
                            "author": "Mimi"
                        }
                    }
        
        DELETE /main/((posts_id))
        Example:    DELETE http://localhost:3000/main/16
        Response:   {
                        "message": "Post has been deleted"
                    }
    
    for comments
        GET /main/(posts_id)/comments/(comments_id)
        Example:    GET http://localhost:3000/main/1/comments/5
        Response:   {
                        "id": 5,
                        "commenter": "Mike vasouski",
                        "body": "love them, like you love yourself.",
                        "post_id": 1,
                        "created_at": "2024-08-13T08:15:44.848Z",
                        "updated_at": "2024-08-13T14:06:17.984Z"
                    }

        POST /main/(posts_id)/comments/
        Example:    POST http://localhost:3000/main/1/comments/
        Body:       {
                        "comment" : {
                            "commenter": "Mike vasouski",
                            "body": "hello, i'm mike"
                        }
                    }

        PUT /main/(posts_id)/comments/(comments_id)
        Example:    PUT http://localhost:3000/main/1/comments/22
        Body:       {
                        "comment" : {
                            "commenter": "Mike vasouski",
                            "body": "hello, i'm mike yoo"
                        }
                    }
        
        DELETE /main/((posts_id))/comments/(comments_id)
        Example:    DELETE http://localhost:3000/main/1/comments/22
        Response:   {
                        "message": "Comment has been deleted"
                    }


        

