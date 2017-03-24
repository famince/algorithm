#约瑟夫环问题
def engine(m, k, i)
  return (m+k-1)%m if 1 == i

  (engine(m-1,k,i-1)+k)%m
end

p '0..9 每第三个出环，循环往复，每个出环的序号为:'
(1..10).each do | i |
  x = engine(10,3,i)
  p "#{i}第#{x}次出环"
end

p '41个人围成圈，每第三个自杀，循环往复，每个人自杀的序号(从0开始)为:'
(1..41).each do | i |
  x = engine(41, 3, i)
  p "第#{x}个人开始自杀"
end
