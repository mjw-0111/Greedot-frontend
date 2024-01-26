## Push 및 Commit

작업 완료된 파일 건드렸으면 절대 push하지 않기(해당 파일 빼고 commit+push)
commit 메시지는 사적인 메시지가 아닌 공적인 요소임을 명심


commit 메시지 작성 요령 [링크](https://kkangsg.tistory.com/95) 

    .gitmessage.txt template 사용


gitcommit template 설정 방법

    git config --global commit.template [.gitmessage.txt 경로]


사용방법

1. .gitmessage 수정 예시

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

2. template 과 vscode 연결

        git config --global core.editor code

3. gitcommit template 사용법

        git commit 

4. vi 편집기가 나온다면
    esc -> :wq!


## pull request 방법

1. fork한 저장소에 할당된 작업 파일만 push
2. fork한 저장소 sync 최신화 
3. 변경 내용 적용 방법과 함께 pull resquest 요청

        # PR 작성 양식
        
        ## Work summary

            로그인 기능을 구현하였습니다.

        ## key change
        
            00버튼에 팝업 로그인 창 기능을 추가하였습니다.
            아직 벡엔드 연결은 하지않은 상태이며 향구 해당 기능 추가 예정입니다.
            해당 기능은 플루터 기본제공 패키지인 [링크]() 사용하여 구현하였습니다.
        
        ## How to use

            XXX.dart 파일에 N 번째줄에 함수에 아래 코드를 추가하여 동작 시킬 수 있습니다.
            
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => gotoScene!()),
                );

        ## issue num(optional)

            이슈 링크 참조

4. 코드 리뷰 이후 관리자가 merge 허용


## 이슈관리


## 컨벤션

Class명 시작은 대문자

    파스칼 표기법 사용 (예시: BackgroundColor, TypeName, IPhone)

funtion 시작은 소문자

    카멜 표기법 사용 (예시: backgroundColor, typeName,iPhone)


우리가 만든 함수나 클래스 greedot  추가하기

    예시: backgroundColor_greedot, TypeName_greedot

변명 또한 카멜 표기법을 사용하며, 가능한 private으로 정의하여 충돌 방지하기 
