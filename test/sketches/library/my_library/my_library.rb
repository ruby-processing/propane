# frozen_string_literal: true

# This class demonstrates how by inheriting from the abstract class LibraryProxy
# we can access 'keyEvent' and 'draw'  (Note we need a draw method even
# though can be empty)
class MyLibrary < LibraryProxy
  java_import 'processing.event.KeyEvent'

  attr_reader :app

  def initialize(parent)
    @app = parent
  end

  def draw # optional
    fill app.color(200, 0, 0, 100)
    app.rect 100, 100, 60, 90
  end

  # favor guard clause no_op unless key pressed
  # and no_op unless ascii key
  def keyEvent(e) # NB: need camel case for reflection to work
    return unless e.get_action == KeyEvent::PRESS
    return if e.get_key > 122 # else we can't use :chr

    case e.get_key.chr.upcase
    when 'S'
      app.send :hide, false
    when 'H'
      app.send :hide, true
    else
      puts e.get_key.chr
    end
  end
end
