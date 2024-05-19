# ToughCookie






#### 트러블 슈팅

app이 background에서 foreground으로 돌아올 때 layout이 안잡힘

tableview를 스크롤해보니 cell이 prepareToReuse가 될 때 다시 뷰가 그려짐

스냅킷을 쓸때는 안나오던 버그이고 flex와 pin을 쓰면서 나타나는 버그인 것 같다.

1. prepareToReuse에 다시 cell의 layout을 다시 잡아줘봤음
-> foreground로 돌아왔을 때 prepareToReuse는 마찬가지로 스크롤을 해줘야만 동작했다

2. foreground로 돌아온걸 통해서 tableView를 리로드해서 cell을 다시 그려보자
-> sceneDelegate에 foreground를 확인할 타입 프로퍼티 클로저를 생성
-> sceneDelegate의 sceneWillEnterForeground를 통해서 클로저를 실행
-> marketsViewController에서 클로저에 tableView reload를 시퀀스로 넣어줌

다행히 foreground에 들어왔을 때 다시 레이아웃을 그려줘서 해결
