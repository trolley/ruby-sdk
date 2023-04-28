require_relative '../../lib/trolley'
require 'test/unit'

class PaginatedArrayTest < Test::Unit::TestCase
  def test_initialize
    paginated_array = Trolley::Utils::PaginatedArray.new([1, 2, 3], 1, 2, 3)
    assert_equal [1, 2, 3], paginated_array
    assert_equal 1, paginated_array.page
    assert_equal 2, paginated_array.pages
    assert_equal 3, paginated_array.records
  end

  def test_from_response
    response = '{"meta":{"page":1,"pages":2,"records":3},"batches":[{"id":1},{"id":2},{"id":3}]}'
    paginated_array = Trolley::Utils::PaginatedArray.from_response(response, Trolley::Batch)
    assert_equal 3, paginated_array.count
    assert_equal Trolley::Batch, paginated_array.first.class

    assert_equal 1, paginated_array.page
    assert_equal 2, paginated_array.pages
    assert_equal 3, paginated_array.records
  end
end
