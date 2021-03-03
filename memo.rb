require 'csv'

# 変数・定数の定義
validation_result = false

# メソッドの定義
def validate_file_name?(name)
  if name[0...1] == '.'
    puts 'ファイル名の先頭は"."以外を指定してください。'
    return false
  elsif name.include?('/') == true
    puts 'ファイル名に"/"は使用できません。'
    return false
  else
    return true
  end
end

def aggregate_input
  line = readlines
  len = line.length
  i = 0
  while i < len
    line[i] = line[i].chomp.split(' ')
    i += 1
  end
  return line
end

# 処理内容
puts '1(新規でメモを作成) 2(既存のメモ編集する)'
memo_type = gets.to_i

case memo_type
  when 1
    while validation_result == false
      puts '拡張子を除いたファイル名を入力してください。'
      csv_file_name = gets.to_s.chomp + '.csv'
      validation_result = validate_file_name?(csv_file_name)
    end
    puts 'メモしたい内容を記入してください。'
    puts '入力が完了したら Ctrl + D を押してください。'
    line = aggregate_input
    CSV.open(csv_file_name, 'w') do |csv|
      line.each do |line_element|
        csv << line_element
      end
    end
    puts "\n----------END----------"
  when 2
    puts '編集したいファイル名を拡張子を含めて入力してください。'
    file_name = gets.to_s.chomp
    if File.exist?(file_name) == true
      puts '追記したい内容を記入してください。'
      puts '入力が完了したら Ctrl + D を押してください。'
      line = aggregate_input
      CSV.open(file_name, 'a') do |csv|
        line.each do |line_element|
          csv << line_element
        end
      end
      puts "\n----------END----------"
    else
      puts '存在しないファイル名が指定されています。もう一度やり直してください。'
      puts "\n----------END----------"
    end
  else
    puts '1,2の数値以外が入力されました。再度ファイルを実行後、1か2の数値を入力してください。'
    puts "\n----------END----------"
end
