# Database Structure

1. User

* email:string
* username:string
* password:string

has_many :posts
has_many :friendships
has_many :friends, through: friendships

2. Post

* user_id:integer
* parent_id:integer:nullable
* body:text

belongs_to :user

3. Message

4. Friendship

* user_id:integer
* friend_id:integer
* accepted:boolean

belongs_to :user
belongs_to :friend, class_name: "User"

5. Like

6. Notification

# Functionalities

1. Sign up for accounts

2. Add friends

3. Make posts

4. Reply to posts

5. Upvote/ downvote posts

6. Search for a user

7. Send private messages

8. Timeline
