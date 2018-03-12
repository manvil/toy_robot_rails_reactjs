module Command
  module Placement
    def valid_placement?
      return false unless valid_numbers?(@current_x, @current_y)
      @current_x = @current_x.to_i
      @current_y = @current_y.to_i
    end

    def valid_numbers?(x, y)
      integers?(x, y) && natural?(x, y) && within_size?(x, y)
    end

    def i?(i)
      i.to_s =~ /\A[-+]?\d+\z/
    end

    def integers?(x, y)
      i?(x) && i?(y)
    end

    def natural?(x, y)
      x.present? && x.to_i.natural? && y.present? && y.to_i.natural?
    end

    def within_size?(x, y)
      x.to_i < @size && y.to_i < @size
    end
  end
end
