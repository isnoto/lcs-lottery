class FileParser
  def parse(path)
    file = File.open(path)
    formatted_data = format_data(file.readlines)
    file.close

    formatted_data
  end

  private

  def format_data(raw_data)
    raw_data.map do |item|
      user = {}
      user_data = item.chomp.split(',')

      user_fields.each_with_index do |value, index|
        user[value] = user_data[index]
      end

      user
    end
  end

  def user_fields
    %i[last_name first_name country ticket_number]
  end
end
