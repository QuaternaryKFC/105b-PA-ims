class TestClass
  attr_reader :id
  attr_accessor :con

  def initialize args={}
    @id = args[:id]
    @con = args[:con]
  end
end
