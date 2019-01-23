require 'minitest/autorun'

require_relative '../../dependencies'
require_relative '../../storage/yaml_adaptor'
require_relative 'test_class'

describe "adaptor test" do
  before do
    $storage = "./"
    @a = YamlAdaptor.new "testclass"
    @t1 = TestClass.new(id: 0, con: false)
    @t2 = TestClass.new(id: 1, con: true)
  end

  it "can insert record" do
    @a.insert(@t1).must_equal true
    @a.entries.size.must_equal 1
    @a.insert(@t1).must_equal false
    @a.delete(@t1)
  end

  it "can delete record" do
    @a.insert(@t1)
    @a.delete(@t1).must_equal true
    @a.entries.size.must_equal 0
    @a.delete(@t1).must_equal false
  end

  it "can update record" do
    @a.insert(@t1)
    @t1.con = true
    @a.update(@t1).must_equal true
    @a.update(@t2).must_equal false
    @t1.con = false
    @a.delete(@t1)
  end

  it "can retrieve all records" do
    @a.insert(@t1)
    @a.insert(@t2)
    @a.all.size.must_equal 2
    @a.delete(@t1)
    @a.delete(@t2)
    @a.all.size.must_equal 0
  end

  it "can retrieve a record by id" do
    @a.insert(@t1)
    @a.insert(@t2)
    @a.find(0).must_equal @t1
    @a.find(1).must_equal @t2
    @a.delete(@t1)
    @a.delete(@t2)
  end

  it "can retrieve records on conditions" do
    @a.insert(@t1)
    @a.insert(@t2)
    @a.where(con: true).map{|r| r.id}.must_equal [1]
    @a.where(con: false).map{|r| r.id}.must_equal [0]
    @a.delete(@t1)
    @a.delete(@t2)
  end
end
