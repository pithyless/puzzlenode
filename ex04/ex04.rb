#
# http://puzzlenode.com/puzzles/4
#
# remimance -> remembrance <?> reminiscence
# => remembrance
#
# inndietlly -> immediately <?> incidentally
# => incidentally
#

def lcs_length(xs, ys)
  rows = xs.length + 1
  cols = ys.length + 1
  lcs = Array.new(rows) { Array.new(cols) }
  rows.times { |x| lcs[x][0] = 0 }
  cols.times { |y| lcs[0][y] = 0 }
  (1...rows).each do |i|
    (1...cols).each do |j|
      if xs[i-1] == ys[j-1]
        lcs[i][j] = lcs[i-1][j-1] + 1
      else
        lcs[i][j] = [ lcs[i][j-1], lcs[i-1][j] ].max
      end
    end
  end
  lcs[rows-1][cols-1]
end

def spellcheck(word, one, two)
  return one if lcs_length(word, one) > lcs_length(word, two)
  two
end

f = File.open(ARGV[0])
entries = f.readline.chomp.to_i
entries.times do |cnt|
  line = f.readline.chomp
  word, one, two = f.readline.chomp, f.readline.chomp, f.readline.chomp
  puts spellcheck(word, one, two)
end
