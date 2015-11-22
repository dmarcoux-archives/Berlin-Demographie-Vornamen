require_relative '../spec_helper'

describe RoutesUtils do
  before do
    @module = Class.new { extend RoutesUtils }

    @model = Class.new(Sequel::Model) do
      def self.common_filters=(h)
        @@common_filters = h
      end

      def self.common_filters
        @@common_filters
      end
    end
  end

  describe '#path_params' do
    describe 'a model without common_filters and anything in path_info' do
      it do
        m = Class.new(Sequel::Model)

        error = proc { @module.path_params(m, '') }.must_raise NoMethodError
        error.name.must_equal 'RoutesUtils.path_params'

        error = proc { @module.path_params(m, '/path/filter1') }.must_raise NoMethodError
        error.name.must_equal 'RoutesUtils.path_params'
      end
    end

    describe 'a model with common_filters' do
      before do
        @model.common_filters = { filter1: { col1: '1' }, filter2: { col2: '2' } }
      end

      describe 'when passing an empty path_info' do
        it 'returns an empty array' do
          @module.path_params(@model, '').must_equal []
        end
      end

      describe 'when passing a path_info containing no common fitlers for the model' do
        it 'returns an empty array' do
          @module.path_params(@model, '/path/filter999').must_equal []
        end
      end

      describe 'when passing a path_info containing common filters for the model' do
        it 'returns an array containing the filters which are present in the path_info' do
          @module.path_params(@model, '/path/filter1').must_equal [{ col1: '1' }]
          @module.path_params(@model, '/path/filter2').must_equal [{ col2: '2' }]
          @module.path_params(@model, '/path/filter1/filter999').must_equal [{ col1: '1' }]
          @module.path_params(@model, '/path/filter1/filter2').must_equal [{ col1: '1' }, { col2: '2' }]
        end
      end
    end
  end

  describe '#sort_params' do
    describe 'a model with allowed columns' do
      before do
        @model.set_allowed_columns(:col1, :col2)
      end

      describe 'when passing params being nil' do
        it 'returns an empty array' do
          @module.sort_params(@model, nil).must_equal []
        end
      end

      describe "when passing in params a String containing columns which aren't allowed" do
        it 'returns an empty array' do
          @module.sort_params(@model, 'col000,-col999').must_equal []
        end
      end

      describe 'when passing in params a String containing columns which some or all are allowed' do
        it "must returns an array containing the allowed columns as Sequel.asc(:col_name) or Sequel.desc(:col_name) if the column name is prepend by '-'" do
          @module.sort_params(@model, '-col1,col2,col999').must_equal [Sequel.desc(:col1), Sequel.asc(:col2)]
          @module.sort_params(@model, 'col1,-col2').must_equal [Sequel.asc(:col1), Sequel.desc(:col2)]
        end
      end
    end

    describe 'a model with no allowed columns' do
      describe 'when passing anything in params' do
        it 'returns an empty array' do
          @module.sort_params(@model, '').must_equal []
          @module.sort_params(@model, 'sort=col1,col2').must_equal []
        end
      end
    end
  end
end
