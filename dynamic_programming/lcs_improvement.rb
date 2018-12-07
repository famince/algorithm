# 最长公共子序列问题(Longest Common Subsequence)

$c = []              # $c[i][j] 存储的是 Xi 和 Yj 的 lcs 长度

# 计算 lcs 长度
def lcs_length(x, y)
  m = x.length
  n = y.length

  (0..m).each_with_index do | i |
    $c[i]    ||= []
    $c[i][0] = 0
  end

  (1..n).each_with_index do | j |
    $c[0]    ||= []
    $c[0][j] = 0
  end

  (1..m).each_with_index do | i |
    (1..n).each_with_index do | j |
      $c[i][j] = if x[i-1] == y[j-1]
                   $c[i-1][j-1] + 1
                 else
                   [$c[i-1][j], $c[i][j-1]].max
                 end
    end
  end

  p '$c: '
  $c.each do | row |
    p row
  end
end

# 打印出 lcs
def print_lcs(c, x, m, n)
  return if(m.zero? || n.zero?)

  if c[m][n] == c[m-1][n]
    print_lcs(c, x, m-1, n)
  elsif c[m][n] == c[m][n-1]
    print_lcs(c, x, m, n-1)
  else c[m][n] == (c[m-1][n-1] + 1)
    print_lcs(c, x, m-1, n-1)
    p x[m-1]
  end
end

x = %w'A B C B D A B'
y = %w'B D C A B A'

lcs_length(x, y)

p 'print_lcs:'
print_lcs($c, x, x.length, y.length)

