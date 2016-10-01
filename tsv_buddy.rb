# Module that can be included (mixin) to take and output TSV data
module TsvBuddy
  require 'csv'
  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format
  def take_tsv(tsv)
    rows = tsv.split("\n").map { |line| line.split("\t") }
    headers = rows.first
    data_rows = rows[1..-1]
    @data = data_rows.map { |row| row.map.with_index { |cell, i| [headers[i], cell] }.to_h }
  end

  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    string_result = @data.first.keys.join("\t").concat("\n")
    #string_result = headers

    @data.each do |row|
      values_string = row.values.join("\t").concat("\n")
      string_result.concat(values_string)
    end
    
    string_result
  end
end
