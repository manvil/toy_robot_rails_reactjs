module IntegerExtension
  def natural?
    present? && (zero? || positive?)
  end
end

Numeric.send(:include, IntegerExtension)
