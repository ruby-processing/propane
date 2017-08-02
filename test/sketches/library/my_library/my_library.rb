# This class demonstrates how by inheriting from the abstract class CustomProxy
# we can access 'keyEvent' and 'draw'  (Note we need a draw method even
# though can be empty)
class MyLibrary < CustomProxy
  java_import 'processing.event.KeyEvent'

  attr_reader :app

  def initialize(parent)
    @app = parent
  end

  def draw # required but empty method is fine
    app.fill(200, 100)
    app.ellipse(150, 100, 200, 60)
  end

  def keyEvent(e) # keep camel case for reflection to work
    return unless e.get_action == KeyEvent::PRESS
    puts e.key_code
  end
end
