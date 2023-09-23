require 'time'

class Memento
  attr_reader :text, :timestamp

  def initialize(text)
    @text = text
    @timestamp = Time.now
  end
end

class TextEditor
  attr_accessor :text

  def initialize
    @text = ''
  end

  def create_memento
    puts "Зберігаємо стан редактора (#{Time.now}):"
    Memento.new(text)
  end

  def restore_memento(memento)
    puts "Відновлюємо стан редактора (#{Time.now}):"
    self.text = memento.text
  end

  def add_text(text_to_add)
    puts "Додаємо текст: #{text_to_add}"
    self.text += text_to_add
  end

  def to_s
    text
  end
end

class Caretaker
  attr_accessor :mementos

  def initialize
    @mementos = []
  end

  def add_memento(memento)
    mementos << memento
  end

  def get_memento(index)
    mementos[index]
  end
end

editor = TextEditor.new
caretaker = Caretaker.new

puts "Стан редактора:"
puts editor
puts "\n"

editor.add_text("Це перший рядок тексту.\n")
caretaker.add_memento(editor.create_memento)

puts "Стан редактора:"
puts editor
puts "\n"

sleep(5)

editor.add_text("Це другий рядок тексту.\n")
caretaker.add_memento(editor.create_memento)

puts "Стан редактора:"
puts editor
puts "\n"

##caretaker.get_memento(0)
editor.restore_memento(caretaker.get_memento(0))

puts "Після скасування:"
puts editor
puts "\n"

editor.add_text("Це третій рядок тексту.\n")
caretaker.add_memento(editor.create_memento)

puts "Стан редактора:"
puts editor
puts "\n"

##caretaker.get_memento(1)
editor.restore_memento(caretaker.get_memento(1))

puts "\n"
puts "Після скасування:"
puts editor
