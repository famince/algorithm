
# 问题：
# 一只青蛙一次可以跳上1级台阶，也可以跳上2级台阶。求该青蛙跳上一个n级台阶总共有多少种跳法。
#
# 一、构造状态转移方程：
#
# 题目中没有给粟子，我们可以自己举点例子。
#
# 例如：跳上一个6级台阶，有多少种跳法；由于青蛙一次可以跳两阶，也可以跳一阶，所以我们可以分成两个情况：
# 1、青蛙最后一次跳了两阶，问题变成了“跳上一个4级台阶台阶，有多少种跳法” 
# 2、青蛙最后一次跳了一阶，问题变成了“跳上一个5级台阶台阶，有多少种跳法” 
# 由上可得:
# f(6) = f(5) + f(4);  
# f(5) = f(4) + f(3);  
#
# 由此类推:f(n)=f(n-1)+f(n-2)
#
#
# *推论：有多少种跳法，就算几种求和，如果是每次可以跳1,2,3级，那么对应公式就是：
# f(n)=f(n-1)+f(n-2)+f(n-3)


def frog_jump stairs_number
  return 0 if stairs_number <= 0
  return 1 if stairs_number.eql? 1
  return 2 if stairs_number.eql? 2

  jump_ways = []
  jump_ways[1] = 1
  jump_ways[2] = 2
  (3..stairs_number).each do | stair_index |
    jump_ways[stair_index] = jump_ways[stair_index-1] + jump_ways[stair_index-2]
  end

  return jump_ways[stairs_number]
end

while true do
  p '请给定台阶数(Q/q退出): '
  input = gets.strip

  break if('q' == input.to_s || 'Q' == input.to_s)

  puts "\e[32m#{input}\e[0m 级台阶，青蛙每次跳1、2级，共有 \e[32m#{frog_jump(input.to_i)}\e[0m 跳法"
  puts '--------------------------------------------------------------------'
end
