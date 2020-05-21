require_relative 'lcs'
require_relative 'file_parser'

class Lottery
  def initialize(winning_number:, file_parser: FileParser.new, lcs: Lcs.new)
    @winning_number = winning_number
    @file_parser = file_parser
    @lcs = lcs
  end

  def run(file_path)
    formatted_data = @file_parser.parse(file_path)
    data_with_credits = calculate_credits(formatted_data)
    aggregated_data = aggregate_result(data_with_credits)
    output_results(aggregated_data)
  end

  private

  def output_results(results)
    formatted_result = results.map do |result|
      "#{result[:user_info]},#{result[:total_credits]}"
    end.join("\n")

    puts formatted_result
  end

  def calculate_credits(users_data)
    users_data.map do |user_data|
      user_data.merge(
        credits: @lcs.find(@winning_number, user_data[:ticket_number]).size
      )
    end
  end

  def aggregate_result(results)
    grouped = results.group_by { |result| aggregation_comparison_keys.map { |key| result[key] } }

    grouped.map do |user_key, data|
      { user_info: user_key.join(','), total_credits: data.sum { |user| user[:credits] } }
    end.sort_by { |data| [data[:total_credits]] }.reverse
  end

  def aggregation_comparison_keys
    %i[last_name first_name country]
  end
end

Lottery.new(winning_number: ARGV.first).run(ARGV.last)
