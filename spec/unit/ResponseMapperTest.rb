require_relative '../../lib/trolley'
require 'test/unit'

class ResponseMapperTest < Test::Unit::TestCase
  def test_build_resource
    response = '{"batch": {"id": 1}}'
    mapper = Trolley::Utils::ResponseMapper.new(response, Trolley::Batch)
    result = mapper.build

    assert_instance_of Trolley::Batch, result
    assert_equal 1, result.id
  end

  def test_build_collection
    response = '{"batches": [{"id": 1}, {"id": 2}]}'
    mapper = Trolley::Utils::ResponseMapper.new(response, Trolley::Batch)
    result = mapper.build

    assert_instance_of Array, result
    assert_equal 2, result.length
    assert_instance_of Trolley::Batch, result[0]
    assert_equal 1, result[0].id
    assert_instance_of Trolley::Batch, result[1]
    assert_equal 2, result[1].id
  end
end
