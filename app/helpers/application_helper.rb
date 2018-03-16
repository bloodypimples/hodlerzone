module ApplicationHelper
  def get_post_hint
    hints = [
      'How are you feeling?',
      'How is the weather today?',
      'How is your portfolio today?',
      'What are your hodls currently?',
      'What pisses you off the most?',
      'Say something...',
      'What do you want to tell the world?'
    ]
    hints[rand(0..(hints.length - 1))]
  end
end
