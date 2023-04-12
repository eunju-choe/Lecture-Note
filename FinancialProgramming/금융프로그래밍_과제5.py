"""

Chap 07: self study 7-3, self study 7-4, self study 7-5
이름: 최은주
학과: 경영학과
학번: 201843324

"""

########## Codes begin here


# ------ self study 7-3 ------
print("self study 7-3")

list1 = []
list2 = []
value = 0

for i in range(4):
    for j in range(5) : 
        list1.append(3 * value)
        value += 1
    
    list2.append(list1)
    list1 = []
    
print(list2)


# ------ self study 7-4 ------
print()
print("self study 7-4")

tt = ((1, 2, 3), (4, 5, 6), (7, 8, 9))

for i in range(3) :
    for j in range(3) :
        print(tt[i][j], end = ' ')
    print()

# ------ self study 7-5 ------
print()
print("self study 7-5")

adults = ['닭', '개', '곰', '고등어', '명태', '말', '호랑이']
kids = ['병아리', '강아지', '능소니', '고도리', '노가리', '망아지', '개호주']
dct = {}
for i in range(len(adults)):
    dct[adults[i]] = kids[i]
    
while (True) :
    adult = input(str(adults) + ' 중 새끼 이름을 알고 싶은 동물은?')
    if adult in dct :
        print(f'<{adult}>의 새끼는 <{dct.get(adult)}>입니다.')
    elif adult == '끝' :
        break
    else :
        print('입력 오류')
