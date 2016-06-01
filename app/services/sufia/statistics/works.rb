module Sufia
  module Statistics
    class Works < OverTime
      private

        def point(min, max)
          query = QueryService.new.build_date_query(min, max)
          GenericWork.where(query).count
        end
    end
  end
end
