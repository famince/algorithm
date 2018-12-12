# 剪绳子
# 一根长度为n的绳子，请把绳子剪成m段 (m和n都是整数，n>1且m>1), 每段绳子的长度记为k[0],k[1],…,k[m].请问k[0]*k[1]…*k[m]可能的最大乘积是多少？
# 例如: 当绳子的长度为8时，我们把它剪成长度分别为2,3,3的三段，此时得到的最大乘积是18. 

def cut_string(string_len) 
  # 长度小于等等于1没办法剪
  # 长度为2的绳子，只有一种剪法，剪成长度为1的绳子，剪后的乘积为1
  # 长度为3的绳子，只有一种剪法，剪成长度为1和2的绳子，剪后的乘积为2
  return 0 if string_len <= 1
  return 1 if string_len == 2
  return 2 if string_len == 3

  max_product = []
  max_product[0] = 0
  max_product[1] = 1
  max_product[2] = 2  # 剪后乘积为1,比不剪还小; 这里不是求自身的值，以不剪为准;
  max_product[3] = 3  # 剪后乘积为2,比不剪还小; 这里不是求自身的值，以不剪为准;

  (4..string_len).each do | i |
    tmp_max = 0
    (1..i/2).each do | j |
      val = max_product[j] * max_product[i - j]
      tmp_max = val > tmp_max ? val : tmp_max
    end

    max_product[i] = tmp_max
  end

  max_product[string_len]
end

while true do
  p 'please input string length: '
  input = gets.strip

  break if('q' == input.to_s || 'Q' == input.to_s)

  p "剪绳子后乘积最大值为: #{cut_string(input.to_i)}"
end
