## Push 및 Commit

작업 완료된 파일 건드렸으면 절대 push하지 않기(해당 파일 빼고 commit+push)
commit 메시지는 사적인 메시지가 아닌 공적인 요소임을 명심


commit 메시지 작성 요령 [링크](https://kkangsg.tistory.com/95) 

    .gitmessage.txt template 사용


gitcommit template 설정 방법

    git config --global commit.template [.gitmessage.txt 경로]


사용방법

1. .gitmessage 수정 예시

        ...
        ################
        # feature : 새로운 기능 추가
        # fix : 버그 수정
        docs : describe commit convention at    README.md
        # test : 테스트 코드 추가
        # refactor : 코드 리팩토링
        # style : 코드 의미에 영향을 주지 않는  변경사항
        # chore : 빌드 부분 혹은 패키지 매니저  수정사항
        ################
    
        ################
        # 본문(추가 설명)을 아랫줄에 작성   (참고하면 좋을 자료 사용한 위젯)  (optional)
    
        ################
        # 꼬릿말(footer)을 아랫줄에 작성    (관련된 이슈 번호 추가)(optional)
        Fixes: issue #N 
        ...


2. gitcommit template 
    git commit

3. vi 편집기가 나온다면
    esc -> :wq!


## 이슈관리


## 컨벤션

Class명 시작은 대문자

    파스칼 표기법 사용 (예시: BackgroundColor, TypeName, IPhone)

funtion 시작은 소문자

    카멜 표기법 사용 (예시: backgroundColor, typeName,iPhone)


우리가 만든 함수나 클래스 greedot  추가하기

    예시: backgroundColor_greedot, TypeName_greedot

변명 또한 카멜 표기법을 사용하며, 가능한 private으로 정의하여 충돌 방지하기 
