# Todos
* Send private messages:
  * Conversation: belongs_to :user, belongs_to :friend, has_many: messages
  * Message: belongs_to :conversation, belongs_to :user
    * body: text
  * User: has_many :conversations, has_many :messages

# Production notes
* ImageMagick must be installed for paperclip
* || used in User.search might not work in production postgresql
