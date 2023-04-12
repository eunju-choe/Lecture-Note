"""

Chap 09: self study 9-1, self study 9-2
이름: 최은주
학과: 경영학과
학번: 201843324

"""

########## Codes begin here


# ------ self study 9-1 ------
print("self study 9-1")
 
def coffee_machine(button) :
     print("#1. (자동으로) 뜨거운 물을 준비한다.")
     print("#2. (자동으로) 종이컵을 준비한다.")
 
     if button == 1 :
          print("#3. (자동으로) 아메리카노를 탄다.")
     if button == 2 :
          print("#3. (자동으로) 카페라떼를 탄다.")
     if button == 3 :
          print("#3. (자동으로) 카푸치노를 탄다.")
     if button == 4 :
          print("#3. (자동으로) 에스프레소를 탄다.")
 
     print("#4. (자동으로) 물을 붓는다.")
     print("#5. (자동으로) 스푼으로 젓는다.")
 
for name in ['로제', '리사', '제니', '지수'] :
    coffee = int(input(f'{name}씨, 어떤 커피 드릴까요? (1:아메리카노, 2:카페라떼, 3:카푸치노, 4:에스프레소)'))
    coffee_machine(coffee)
    print(f'{name}씨~ 커피 여기 있습니다.')

# ------ self study 9-2 ------
print()
print("self study 9-2")

def calc(v1, v2, op):
    if op == '+':
        result = v1 + v2
    elif op == '-':
        result = v1 - v2
    elif op == '*':
        result = v1 * v2
    elif op == '/':
        result = v1 / v2
    elif op == '**':
        result = v1 ** v2
 
    return result

var1 = int(input('첫 번째 수를 입력하세요 : '))
oper = input('계산을 입력하세요 (+, -, *, /, **) :')
var2 = int(input('두 번째 수를 입력하세요 : '))

if (oper == '/') & (var2 == 0) :
    print('0으로는 나누면 안 됩니다. ㅠㅠ')
else :
    res = calc(var1, var2, oper)
    print(f'## 계산기 {var1} {oper} {var2} = {res}')