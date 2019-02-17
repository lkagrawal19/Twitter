1 Create an User

/users/create - POST

{
  "user": {
    "email": "lkagrawal19@gmail.com",
    "password": "lokesh19@",
    "username": "lkagrawal19"
  }
}

Response:
  {
    "status": 200,
    "msg": "User was created."
` }

2 create JWT Token

/user_token/ - POST

{
  "auth": {
    "email": "lkagrawal19@gmail.com",
    "password": "lokesh19@"
  }
}

Response:
 {
    "jwt": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1NTA0NzAzNDYsInN1YiI6MX0.-iM_lWb0ZOguF-dtaG_MLBzdq-C5ArnvbmFGAqX1QWc"
 }

# How to do Tweets
  Headers:
       1. Content-Type: Application/json
       2. Authorization: Bearer jwt_secret
  endpoint: micropost/create -- POST
    {
      "content": "Hi All, This is my first tweet"
    }
  
# How to follow user

  endpoint: /follow  -- POST
  Headers:
       1. Content-Type: Application/json
       2. Authorization: Bearer jwt_secret
       
    {
      "followed_id": 4
    }
    ** followed id is user_id of the user need to be followed.
    
# Tweets of the people they are following
   endpoint: /following_tweets -- Get
   Headers:
       1. Content-Type: Application/json
       2. Authorization: Bearer jwt_secret
       
     Response: {
        "following_posts": [
            {
                "content": "user 3",
                "created_at": "2019-02-16T20:23:32.000Z",
                "following_user": "lkagrawal1994"
            },
            {
                "content": "user 3",
                "created_at": "2019-02-16T20:23:32.000Z",
                "following_user": "lkagrawal1994"
            }
        ]
      }
      
 *** not sorted for now, need to do it, the schema need to be changed for this.

# Technologies used
  Framework: ROR 5.0.13
  Database: Mysql
  API Authentication: JWT
  Tools: SequelPro
  Github for versioning
  
#schema
  create_table "microposts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t| 
    t.string "content"
    t.string "string"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_microposts_on_user_id"
  end

  create_table "relationships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "password_digest"
    t.string "role", default: "user", null: false
    t.datetime "last_login"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
  end

  add_foreign_key "microposts", "users"
  
  # API to return the tweets on dashboard
    endpoint: /dashboard
    
    Headers:
       1. Content-Type: Application/json
       2. Authorization: Bearer jwt_secret
       
     Response:
             {
              "my_posts": [
                  {
                      "content": "Lokesh is a good boy"
                   },
                  {
                      "content": "Sachin"
                  }
                ]
            }
            
 # Scaling up the application
   Actually there is a lot to scale up the appliation.
   1. The schema need to change to accomodate the follower tweets.
   2. Auto notification when a user is logged in and follower post something. //might be web socker help here.
   3. Preloading or Eager Loading of all the followed user. So everytime we dont need to connect to db.
   4. Pagination : Json response wont scale up if lot of micropost will be there.
   5. Docker: Its better if we use the docker container so versioning problems of different gems wont occur.
   6. Test cases.
   7. Error handling.
  
