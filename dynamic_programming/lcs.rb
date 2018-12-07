# 最长公共子序列问题(Longest Common Subsequence)

$c = []              # $c[i][j] 存储的是 Xi 和 Yj 的 lcs 长度
$b = []              # $b[i][j] 存储的是 c[i][j] 时选择的最优解

# 计算 lcs 长度
def lcs_length(x, y)
  m = x.length
  n = y.length

  (0..m).each_with_index do | i |
    $b[i]    ||= []
    $b[i][0] = ''
    $c[i]    ||= []
    $c[i][0] = 0
  end

  (1..n).each_with_index do | j |
    $c[0]    ||= []
    $c[0][j] = 0
    $b[0][j] = ''
  end

  (1..m).each_with_index do | i |
    (1..n).each_with_index do | j |
      if x[i-1] == y[j-1] 
        $c[i][j] = $c[i-1][j-1] + 1
        $b[i][j] = 'lt'                # left-top
      else
        if $c[i-1][j] >= $c[i][j-1]
          $c[i][j] = $c[i-1][j]
          $b[i][j] = 'tp'              # top
        else
          $c[i][j] = $c[i][j-1]
          $b[i][j] = 'lf'              # left
        end
      end
    end
  end

  p '$c: '
  $c.each do | row |
    p row
  end

  p '$b: '
  $b.each do | row |
    p row
  end
end

# 打印出 lcs
def print_lcs(b, x, m, n)
  return if(m.zero? || n.zero?)

  if b[m][n] == 'lt'            # left-top
    print_lcs(b, x, m-1, n-1)
    p x[m-1]
  elsif b[m][n] == 'tp'         # top
    print_lcs(b, x, m-1, n)
  else
    print_lcs(b, x, m, n-1)
  end
end

x = %w'A B C B D A B'
y = %w'B D C A B A'

lcs_length(x, y)

p 'print_lcs:'
print_lcs($b, x, x.length, y.length)
