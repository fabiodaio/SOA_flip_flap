# Module that can be included (mixin) to take and output TSV data
module TsvBuddy
  # write_tsv_data: write a String in TSV format with values from an Hash
  # parameter: row - an Hash correspoding to one document row
  def write_tsv_data(row)
    row.values.join("\t").concat("\n")
  end

  # generate_tsv_string: generate final_string in TSV format with all data
  def generate_tsv_string
    # write first line: the headers
    final_string = @data.first.keys.join("\t").concat("\n")
    # write remaining data
    @data.each do |row|
      final_string.concat(write_tsv_data(row))
    end
    final_string
  end

  # hashing: create Hash of headers => row values
  # parameter: headers - array with keys
  # parameter: row - array with values
  def hashing(headers, row)
    row.map.with_index { |cell, i| [headers[i], cell] }.to_h
  end

  # get_rows_from_tsv: get array of all rows from tsv doc
  # parameter: tsv_doc - tsv document
  def get_rows_from_tsv(tsv_doc)
    tsv_doc.split("\n").map { |line| line.split("\t") }
  end

  # tsv_to_array_of_hashes: convert tsv to an array of hashes
  # parameter: tsv - tsv document to be converted
  def tsv_to_array_of_hashes(tsv)
    rows = get_rows_from_tsv(tsv)
    headers = rows.first
    data_rows = rows[1..-1]
    @data = data_rows.map do |row|
      hashing(headers, row)
    end
  end

  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format
  def take_tsv(tsv)
    tsv_to_array_of_hashes(tsv)
  end

  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    generate_tsv_string
  end
end
