"""

06_반복문: self study 6-7, self study 6-8, self study 7-1
이름: 최은주
학과: 경영학과
학번: 201843324

"""

########## Codes begin here


# ------ self study 6-7 ------
print("self study 6-7")

hap = 0
i = 1

while i <= 100 :
    hap += i
    if hap >= 1000 :
        break
    i += 1

print('1 ~ 100의 합계를 최초로 1000이 넘게 하는 숫자 :', i)

# ------ self study 6-8 ------
print('')
print("self study 6-8")

for i in range(0, 9) : 
    if i < 5 :
        k = 0
        for k in range(0, 9) :
            if k < 4 - i :
                print('  ', end = '')
            else :
                continue
        for k in range(0, 9) :
            if k < i * 2 + 1 :
                print('\u2665', end = '')
            else :
                continue
    else :
        for k in range(0, 9):
            if k < i - 4 :
                print('  ', end = '')
            else :
                continue
        for k in range(0, 9):
            if k < (9 - i) * 2 - 1 :
                print('\u2665', end = '')
            else :
                continue
    print('')

# ------ self study 7-1 ------
print('')
print("self study 7-1")

aa = []
for i in range(0, 10) :
    aa.append(0)

for i in range(0, 10):
    aa[i] = int(input(f'{i + 1}번째 숫자 : '))

hap = 0
i = 0
while i <= 9 :
    hap += aa[i]
    i += 1

print('합계 ==>', hap)
