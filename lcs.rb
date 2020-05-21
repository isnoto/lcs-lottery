class Lcs
  EMPTY_STRING_SHIFT = 1

  def find(first_num, second_num)
    first_str = first_num.to_s
    second_str = second_num.to_s
    result = build_matrix(first_str, second_str)

    (EMPTY_STRING_SHIFT..second_str.size).each do |i|
      (EMPTY_STRING_SHIFT..first_str.size).each do |j|
        result[i][j] =
          if second_str[i - 1] == first_str[j - 1]
            result[i - 1][j - 1] + [second_str[i - 1]]
          else
            [result[i][j - 1], result[i - 1][j]].max_by(&:length)
          end
      end
    end

    result[-1][-1]
  end

  private

  def build_matrix(first_str, second_str)
    Array.new(second_str.size + EMPTY_STRING_SHIFT) do
      Array.new(first_str.size + EMPTY_STRING_SHIFT) { [] }
    end
  end
end
