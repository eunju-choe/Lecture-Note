"""

Chap 08: self study 8-1, self study 8-2, self study 8-3
이름: 최은주
학과: 경영학과
학번: 201843324

"""

########## Codes begin here


# ------ self study 8-1 ------
print("self study 8-1")

ss = '파이썬은완전재미있어요'

for i in range(len(ss)):
    if i%2 == 0 :
        print(ss[i], end = '')
    else :
        print('#', end ='')



# ------ self study 8-2 ------
print('\n')

print("self study 8-2")

inStr = '<<<파<<이>>썬>>>'
outStr = ''

for i in range(len(inStr)):
    if (inStr[i] != '<') & (inStr[i] != '>') :
        outStr += inStr[i]
        
print('원래 문자열 ==> ', inStr)
print('공백 삭제 문자열 ==>', outStr)


# ------ self study 8-3 ------
print('')
print("self study 8-3")

instr = input('문자열 입력 : ')
if instr.isalpha() == True:
    print('글자입니다.')
elif instr.isdigit() == True:
    print('숫자입니다.')
elif instr.isalnum() == True:
    print('글자 + 숫자입니다.')
else :
    print('모르겠습니다.')
