"""

06_반복문: 0과 100 사이에 있는 7의 배수 합계 구하기 / 구구단 거꾸로 출력하기

이름: 최은주
학과: 경영학과
학번: 201843324

"""

########## Codes begin here


# ------ 0과 100 사이에 있는 7의 배수 합계 구하기 ------
print("\n\n[0과 100 사이에 있는 7의 배수 합계 구하기]\n")

hap = 0

for i in range(0, 101, 7):
    hap += i

print('0과 100 사이에 있는 7의 배수 합계 : ', hap)

# ------ 구구단 거꾸로 출력하기 ------
print("\n\n[구구단 거꾸로 출력하기]\n")

dan = int(input('단을 입력하세요 : '))

for i in range(9, 0, -1):
    print(f'{dan} X {i} = {dan * i}')
