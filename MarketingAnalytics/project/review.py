from bs4 import BeautifulSoup
import time
import pandas as pd
from selenium.common.exceptions import NoSuchElementException
from selenium.webdriver.common.keys import Keys
from selenium import webdriver
from bs4 import BeautifulSoup
from selenium.webdriver.common.action_chains import ActionChains
import time
import pandas as pd

def down_scroll_to_last(driver, max_count=100):
    """
    입력한 max_count만큼 스크롤을 내리는 함수
    참고 : https://blog.naver.com/kibani/222502012433
    """
    last_height = 0
    try_count = 0
    scroll_count = 0

    # 스크롤 : 더 이상 내릴 페이지가 없으면 멈춤
    while True:
        now_height = driver.execute_script(
            'return document.body.scrollHeight;')
        if last_height == now_height:
            if try_count > 10:
                break
        else:
            try_count = 0
            scroll_count += 1
            if scroll_count > max_count:
                break

        last_height = now_height
        driver.execute_script(
            'window.scrollTo(0, document.body.scrollHeight);')
        time.sleep(0.2)
        try_count += 1


def get_language_id(language):
    """
    language를 입력받아 language ID를 반환
    
    한국어 : kr
    영어 : en
    중국어 간체 : ch
    중국어 번체 : ch2
    일본어 : jp
    """
    
    if language == 'kr':
        a = 'menu-item-40'
    elif language == 'en':
        a = 'menu-item-0'
    elif language == 'ch':
        a = 'menu-item-32'
    elif language == 'ch2':
        a = 'menu-item-43'
    elif language == 'jp':
        a = 'menu-item-30'

    return a


def tripadvisor_review(driver_path, url, language, save_path, loc_name):
    """
    tripadvisor 리뷰를 크롤링
    해당 언어의 리뷰가 끝나는 부분에는 다른 언어 데이터가 자동 번역될 수 있음
    그 부분은 크롤링 후에 csv 파일에서 제거하는 게 빨라서 프로그래밍 생략
    
    driver_path : chrome driver의 path
    url : tripadvisor의 url
    language : 'kr', 'en', 'ch', 'ch2', 'jp'
    save_path : 저장 경로
    loc_name : 장소 이름
    """

    driver = webdriver.Chrome(driver_path)
    driver.maximize_window()
    driver.get(url)
    time.sleep(5)
    down_scroll_to_last(driver, 3)

    # 리뷰 언어 설정
    language_ID = get_language_id(language)
    driver.find_element_by_css_selector(
        'div.dhdUM > div:nth-child(2) > button').click()
    time.sleep(5)
    driver.find_element_by_id(language_ID).click()
    time.sleep(5)

    print(f'### {language} 크롤링 시작 ###')

    # 크롤링 결과 리스트 생성
    visit_info, write_time, score, title, text = [], [], [], [], []

    # 크롤링 시작
    while True:
        down_scroll_to_last(driver, 3)
        time.sleep(5)
        soup = BeautifulSoup(driver.page_source, 'html.parser')
        total = soup.select('div.ebHXW > div')

        for i in range(0, 10):
            # 작성자별로 리뷰 수집
            try:
                user = total[i]
            except IndexError:
                break

            # 방문 정보
            try:
                visit_info.append(user.select('div.cLyMB')[0].text)
            except:
                visit_info.append(None)
                
            # 작성일
            try:
                write_time.append(
                    user.select('div.WlYyy.diXIH.cspKb.bQCoY')[0].text)
            except:
                write_time.append(None)
                
            # 별점
            try:
                score.append(user.select('svg.RWYkj')[0]['title'])
            except:
                score.append(None)
                
            # 리뷰 제목
            try:
                title.append(user.select('span.cSoNT')[0].text)
            except:
                title.append(None)
                
            # 리뷰 내용
            try:
                text.append(user.select('span.cSoNT')[1].text)
            except:
                text.append(None)

        # 자동 번역된 데이터가 수집되면, 해당 언어 리뷰 수집이 완료되었다는 뜻
        # 크롤링 중단
        if '由 Asia Online Language Studio 翻譯' in write_time \
        or '번역: Asia Online Language Studio' in write_time \
        or '由 Asia Online Language Studio 翻译' in write_time:
            print('수집 중단 - 해당 언어 수집 끝')
            break

        # 다음 페이지 버튼이 존재하면 다음페이지 클릭
        # 다음 페이지 버튼이 없으면 수집 중단
        try:
            element = driver.find_element_by_css_selector(
                'div.cCnaz > div > a')
            action = ActionChains(driver)
            action.move_to_element(element).perform()
            time.sleep(5)
            element.click()
            time.sleep(5)
        except:
            print('수집 중단 - 다음 페이지 없음')
            break

    driver.close()

    # 데이터 프레임 생성
    df = pd.DataFrame({
        '방문 정보': visit_info,
        '작성일': write_time,
        '별점': score,
        '제목': title,
        '내용': text
    })
    save_name = save_path + '/' + loc_name + '_' + language + '.csv'
    df.to_csv(save_name, index=False)
    print(f'{save_name} 저장 완료')

    return df


### 한국어 리뷰 전처리 ###
def kr_visit_info_split(df):
    """
    한국어 리뷰의 방문 정보를 영어로 변환
    """
    map_comp = {
        '친구': 'Friends',
        '가족': 'Family',
        '개인': 'Solo',
        '비지니스': 'Business',
        '커플': 'Couples'
    }
    temp = list(df['방문 정보'].str.split('•'))

    date = []
    comp = []
    for i in range(len(temp)):
        try:
            date.append(temp[i][0].rstrip(' '))
        except:
            date.append(None)

        try:
            comp.append(temp[i][1].lstrip(' '))
        except:
            comp.append(None)

    results = []
    for i in range(len(date)):
        try:
            temp = date[i].split('년')
            year = temp[0]
            month = temp[1].rstrip('월').strip(' ')
            result = year + '-' + month
            results.append(result)
        except:
            results.append(None)

    df['visit_date'] = results
    df['company'] = comp
    df['company'] = df['company'].map(map_comp)

    df = df.drop('방문 정보', axis=1)

    return df


def kr_write_date(df):
    """
    한국어 리뷰의 작성일을 영어로 변환
    """
    a = df['작성일'].apply(lambda x: x.rstrip(' 작성'))

    date = []
    for i in range(len(a)):
        temp = a.iloc[i].split('년')
        year = temp[0].strip(' ')
        temp = temp[1].split('월')
        month = temp[0].strip(' ')
        day = temp[1].rstrip('일').strip(' ')
        result = year + '-' + month + '-' + day

        date.append(result)

    df['write_date'] = date
    df = df.drop('작성일', axis=1)

    return df


def kr_stars(df):
    """
    한국어 리뷰의 별점을 영어로 변환
    """
    df['stars'] = df['별점'].apply(lambda x: float(x.split(' ')[-1]))
    df = df.drop('별점', axis=1)

    return df


def kr_1st_process(df):
    """
    한국어 리뷰 정보들을 영어로 변환
    """
    df = kr_visit_info_split(df)
    df = kr_write_date(df)
    df = kr_stars(df)
    return df


### 중국어 리뷰 전처리 ###
def ch_visit_info_split(df):
    """
    중국어 리뷰의 방문 정보를 영어로 변환
    """
    map_comp = {
        '好友': 'Friends',
        '家庭': 'Family',
        '独自旅游': 'Solo',
        '商务型': 'Business',
        '夫妻情侣': 'Couples'
    }
    temp = list(df['방문 정보'].str.split('•'))

    date = []
    comp = []
    for i in range(len(temp)):
        try:
            date.append(temp[i][0].rstrip(' '))
        except:
            date.append(None)

        try:
            comp.append(temp[i][1].lstrip(' '))
        except:
            comp.append(None)

    results = []
    for i in range(len(date)):
        try:
            temp = date[i].split('年')
            year = temp[0]
            month = temp[1].rstrip('月').strip(' ')
            result = year + '-' + month
            results.append(result)
        except:
            results.append(None)

    df['visit_date'] = results
    df['company'] = comp
    df['company'] = df['company'].map(map_comp)
    df = df.drop('방문 정보', axis=1)

    return df


def ch_write_date(df):
    """
    중국어 리뷰의 작성일을 영어로 변환
    """
    a = df['작성일']

    date = []
    for i in range(len(a)):
        try:
            temp = a.iloc[i].lstrip('撰写日期：').split('年')
            year = temp[0]
            temp = temp[1].split('月')
            month = temp[0]
            day = temp[1].rstrip('日')
            result = year + '-' + month + '-' + day
            date.append(result)
        except:
            date.append(None)

    df['write_date'] = date
    df = df.drop('작성일', axis=1)

    return df


def ch_stars(df):
    """
    중국어 리뷰의 별점을 영어로 변환
    """
    df['stars'] = df['별점'].apply(lambda x: float(x.split('分')[0]))
    df = df.drop('별점', axis=1)

    return df


def ch_1st_process(df):
    """
    중국어 리뷰 정보들을 영어로 변환
    """
    df = ch_visit_info_split(df)
    df = ch_write_date(df)
    df = ch_stars(df)
    return df


### 중국어 번체 리뷰 전처리 ###
def ch2_visit_info_split(df):
    """
    중국어 번체 리뷰의 방문 정보를 영어로 변환
    """
    map_comp = {
        '好友旅行': 'Friends',
        '家庭式': 'Family',
        '單獨旅行': 'Solo',
        '商務型': 'Business',
        '夫妻情侶': 'Couples'
    }
    temp = list(df['방문 정보'].str.split('•'))

    date = []
    comp = []
    for i in range(len(temp)):
        try:
            date.append(temp[i][0].rstrip(' '))
        except:
            date.append(None)

        try:
            comp.append(temp[i][1].lstrip(' '))
        except:
            comp.append(None)

    results = []
    for i in range(len(date)):
        try:
            temp = date[i].split('年')
            year = temp[0]
            month = temp[1].rstrip('月').strip(' ')
            result = year + '-' + month
            results.append(result)
        except:
            results.append(None)

    df['visit_date'] = results
    df['company'] = comp
    df['company'] = df['company'].map(map_comp)
    df = df.drop('방문 정보', axis=1)

    return df


def ch2_write_date(df):
    """
    중국어 번체 리뷰의 작성일을 영어로 변환
    """
    a = df['작성일']

    date = []
    for i in range(len(a)):
        try:
            temp = a.iloc[i].lstrip('發表日期：').split('年')
            year = temp[0]
            temp = temp[1].split('月')
            month = temp[0]
            day = temp[1].rstrip('日')
            result = year + '-' + month + '-' + day
            date.append(result)
        except:
            date.append(None)

    df['write_date'] = date
    df = df.drop('작성일', axis=1)

    return df


def ch2_stars(df):
    """
    중국어 번체 리뷰의 별점을 영어로 변환
    """
    df['stars'] = df['별점'].apply(lambda x: float(x.split('分')[0]))
    df = df.drop('별점', axis=1)

    return df


def ch2_1st_process(df):
    """
    중국어 번체 리뷰 정보들을 영어로 변환
    """
    df = ch2_visit_info_split(df)
    df = ch2_write_date(df)
    df = ch2_stars(df)
    return df


### 일본어 리뷰 전처리 ###
def jp_visit_info_split(df):
    """
    일본어 리뷰의 방문 정보를 영어로 변환
    """
    map_comp = {
        '友達': 'Friends',
        'ファミリー': 'Family',
        '一人': 'Solo',
        'ビジネス': 'Business',
        'カップル・夫婦': 'Couples'
    }
    temp = list(df['방문 정보'].str.split('•'))

    date = []
    comp = []
    for i in range(len(temp)):
        try:
            date.append(temp[i][0].rstrip(' '))
        except:
            date.append(None)

        try:
            comp.append(temp[i][1].lstrip(' '))
        except:
            comp.append(None)

    results = []
    for i in range(len(date)):
        try:
            temp = date[i].split('年')
            year = temp[0]
            month = temp[1].rstrip('月').strip(' ')
            result = year + '-' + month
            results.append(result)
        except:
            results.append(None)

    df['visit_date'] = results
    df['company'] = comp
    df['company'] = df['company'].map(map_comp)
    df = df.drop('방문 정보', axis=1)

    return df


def jp_write_date(df):
    """
    일본어 리뷰의 작성일을 영어로 변환
    """
    a = df['작성일']

    date = []
    for i in range(len(a)):
        try:
            temp = a.iloc[i].lstrip('投稿日：').split('年')
            year = temp[0]
            temp = temp[1].split('月')
            month = temp[0]
            day = temp[1].rstrip('日')
            result = year + '-' + month + '-' + day
            date.append(result)
        except:
            date.append(None)

    df['write_date'] = date
    df = df.drop('작성일', axis=1)

    return df


def jp_stars(df):
    """
    일본어 리뷰의 별점을 영어로 변환
    """
    df['stars'] = df['별점'].apply(lambda x: float(x.split('中 ')[1]))
    df = df.drop('별점', axis=1)

    return df


def jp_1st_process(df):
    """
    일본어 리뷰 정보들을 영어로 변환
    """
    df = jp_visit_info_split(df)
    df = jp_write_date(df)
    df = jp_stars(df)
    return df


### 영어 리뷰 전처리 ###
def en_visit_info_split(df):
    """
    영어 리뷰의 방문 정보 형식 통일
    """
    temp = list(df['방문 정보'].str.split('•'))

    date = []
    comp = []
    for i in range(len(temp)):
        try:
            date.append(temp[i][0].rstrip(' '))
        except:
            date.append(None)

        try:
            comp.append(temp[i][1].lstrip(' '))
        except:
            comp.append(None)

    results = []
    for i in range(len(date)):
        try:
            temp = date[i].split(' ')
            year = temp[1]
            month = temp[0]

            if month == 'Jan':
                month1 = 1
            elif month == 'Feb':
                month1 = 2
            elif month == 'Mar':
                month1 = 3
            elif month == 'Apr':
                month1 = 4
            elif month == 'May':
                month1 = 5
            elif month == 'Jun':
                month1 = 6
            elif month == 'Jul':
                month1 = 7
            elif month == 'Aug':
                month1 = 8
            elif month == 'Sep':
                month1 = 9
            elif month == 'Oct':
                month1 = 10
            elif month == 'Nov':
                month1 = 11
            elif month == 'Dec':
                month1 = 12

            result = year + '-' + str(month1)
            results.append(result)
        except:
            results.append(None)

    df['visit_date'] = results
    df['company'] = comp
    df = df.drop('방문 정보', axis=1)

    return df


def en_write_date(df):
    """
    영어 리뷰의 작성일 형식 통일
    """
    a = df['작성일']

    date = []
    for i in range(len(a)):
        try:
            temp = a[i].lstrip('Written ').split(', ')
            year = temp[1]
            temp = temp[0].split(' ')
            month = temp[0]
            day = temp[1]

            if month == 'January':
                month1 = 1
            elif month == 'February':
                month1 = 2
            elif month == 'March':
                month1 = 3
            elif month == 'April':
                month1 = 4
            elif month == 'May':
                month1 = 5
            elif month == 'June':
                month1 = 6
            elif month == 'July':
                month1 = 7
            elif month == 'August':
                month1 = 8
            elif month == 'September':
                month1 = 9
            elif month == 'October':
                month1 = 10
            elif month == 'November':
                month1 = 11
            elif month == 'December':
                month1 = 12

            result = year + '-' + str(month1) + '-' + day
            date.append(result)

        except:
            date.append(None)

    df['write_date'] = date
    df = df.drop('작성일', axis=1)

    return df


def en_stars(df):
    """
    영어 리뷰의 별점 형식 통일
    """
    df['stars'] = df['별점'].apply(lambda x: float(x.split(' of ')[0]))
    df = df.drop('별점', axis=1)

    return df


def en_1st_process(df):
    """
    영어 리뷰의 정보들 형식 통일
    """
    df = en_visit_info_split(df)
    df = en_write_date(df)
    df = en_stars(df)
    return df