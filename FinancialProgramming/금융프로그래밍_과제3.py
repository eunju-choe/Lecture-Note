"""

06_반복문: Code06-05.py를 while문으로 수정
self study 6-5
이름: 최은주
학과: 경영학과
학번: 201843324

"""

########## Codes begin here
print("\n\n[Code06-05.py를 while문으로 수정]\n")

num1, num2, num3 = map(int, input('"시작값, 끝값, 증가값"의 형식으로 입력하세요').split(', '))
i = 0
hap = 0
while num1 + num3*i <= num2:
    temp = num1 + num3*i
    hap += temp
    i += 1
print(f'{num1}에서 {num2}까지 {num3}씩 증가시킨 값의 합계 : {hap}')


