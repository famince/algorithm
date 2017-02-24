
class AssemblyLine
  def initialize( n, e, x, a, t )
    @n = n      #装配线的装配站数量(the number of assembly station)
    @e = e      #进入装配站花费的时间(the time of entering assembly line i, i = 0, 1)
    @x = x      #离开装配站花费的时间(the time of leaving assemblu line i, i = 0, 1)
    @a = a      #在装配站上花费的时间(the time cost on assembly station)
    @t = t      #不同装配线间移动所花费时间(the transfering time of leaving assembly station to another assembly line)
  end

  def FastestWay
    f = Array.new(2) { Array.new(6, 0) }  # 记录通过 Si,j 的上一个点是经过的装配线编号;
    l = Array.new(2) { Array.new(6, 0) }  # 记录最优路线花费时间;

    f[0][0] = @e[0] + @a[0][0]
    f[1][0] = @e[1] + @a[1][0]

    (1...6).each do | j |
      # 如果 从 S0,j-1 到 S0,j 比从 S1,j-1 转过来花的时间少:
      # 1. 则最短时间是从 S0,j-1 至 S0,j;
      # 2. 反之，则从 S1,j-1 转过来更快;
      if (f[0][j - 1] + @a[0][j] <= f[1][j - 1] + @t[1][j - 1] + @a[0][j])
        f[0][j] = f[0][j - 1] + @a[0][j]
        l[0][j] = 0
      else
        f[0][j] = f[1][j - 1] + @t[1][j - 1] + @a[0][j]
        l[0][j] = 1
      end

      # 如果 从 S1,j-1 到 S0,j 比从 S0,j-1 转过来花的时间少:
      # 1. 则最短时间是从 S1,j-1 至 S1,j;
      # 2. 反之，则从 S0,j-1 转过来更快;
      if (f[1][j - 1] + @a[1][j] <= f[0][j - 1] + @t[0][j - 1] + @a[1][j])
        f[1][j] = f[1][j - 1] + @a[1][j]
        l[1][j] = 1
      else
        f[1][j] = f[0][j - 1] + @t[0][j - 1] + @a[1][j]
        l[1][j] = 0
      end
    end

    # 判断从 S0,n-1 出来更快，还是从 S1,n-1 出来 更快
    if (f[0][@n - 1] + @x[0] <= f[1][@n - 1] + @x[1])
        ftotal = f[0][@n - 1] + @x[0]
        lend = 0
    else
        ftotal = f[1][@n - 1] + @x[1]
        lend = 1
    end

    p "最短耗时为: #{ftotal}"
    print_station(l, lend)
  end

  # 倒序输出装配站流程:
  # params:
  # l:         记录装配线编号, li,j(j=1..n-1) 表示通过配送站 Si,j 的前一个装配线编号;
  # line_of_end: 从配送系统出来的线编号(0, 1);
  def print_station(l, line_of_end)
    i = line_of_end + 1;   #

    p "第 #{@n} 站: 经过 line: #{i} station: #{@n}"
    (1..@n-1).to_a.reverse.each do | j |
      i = l[i][j]  # 经过 S(i,j) 之前一个点所在的装配线;
      p "第 #{j} 站: 经过 line: #{i + 1} station: #{j}"
    end
  end

end


n = 6
e = [2, 4]
x = [3, 2]
a = [[7, 9, 3, 4, 8, 4], [8, 5, 6, 4, 5, 7]]
t = [[2, 3, 1, 3, 4], [2, 1, 2, 2, 1]]

line = AssemblyLine.new(n, e, x, a, t)
line.FastestWay
