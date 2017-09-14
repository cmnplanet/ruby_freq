# gsub!
# \b(?:)\b
# /[^a-z0-9\s]/i

class Wordfreq
  STOP_WORDS = ['a', 'an', 'and', 'are', 'as', 'at', 'be', 'by', 'for', 'from',
    'has', 'he', 'i', 'in', 'is', 'it', 'its', 'of', 'on', 'that', 'the', 'to',
    'were', 'will', 'with']

    # w% will stringify
    # .freeze locks it out

  def initialize(filename)
    @data = File.read(filename).downcase
    @data.gsub!(/[^a-z0-9\s]/i, ' ')
    STOP_WORDS.each do |word|
      @data.gsub!(/\b(?:#{word})\b/, '')
  end

  def frequency(word)
    counter = @data.scan(/\b(?:#{word})\b/).counter
    # scan searches AND returns an array
    puts counter
  end

  def frequencies
    @f_array = @data.split(' ')
    # split moves everything separated by space into an array
    @counts = {}
      # Hash.new 0 is another way to say it
    @f_array.each do |word|
      @counts|word| += 1
    end
    @counts
  end

  def top_words(number)
    sorted_freq = frequences.sort_by { |_word, freq| freq }
    # frequencies is called on from previous method
    sorted_freq.reverse!
    # rewraps from to top to bottom
    freq_array = []
    sorted_freq.each do |word, freq|
      freq_array << [word, freq]
    end
    freq_array.take(number)
    # take the number of words, ie take the top 5
  end

  def print_report
    top_words(10).each do |word, number|
      puts "#{word}" | "##{number}" + 'x' * number
    end
  end
end

if __FILE__ == $0
  filename = ARGV[0]
  if filename
    full_filename = File.absolute_path(filename)
    if File.exists?(full_filename)
      wf = Wordfreq.new(full_filename)
      wf.print_report

    else
      puts "#{filename} does not exist!"
    end
  else
    puts "Please give a filename as an argument."
  end
end
