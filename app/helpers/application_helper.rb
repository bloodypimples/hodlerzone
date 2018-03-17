module ApplicationHelper
  def get_post_hint
    hints = [
      'What pisses you off the most?',
      'Who pisses you off the most?',
      'What would you like to say to your boss?',
      'What do you think about the current state of society?'
    ]
    hints[rand(0..(hints.length - 1))]
  end
end
