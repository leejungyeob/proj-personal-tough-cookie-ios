# ToughCookie

<p align="center">
    <img src = "https://github.com/DONOTINTO/ToughCookie/assets/123792519/e8bd35d4-5b80-4e28-a265-0783616155ca" align="center" width="32%">
	<img src = "https://github.com/DONOTINTO/ToughCookie/assets/123792519/de994c14-6a87-41b6-b279-55936e7c0920" align="center" width="32%">
	<img src = "https://github.com/DONOTINTO/ToughCookie/assets/123792519/8339a11c-8e4c-4430-ab37-a0711312f932" align="center" width="32%">

</p> <br>

## 앱 소개 및 기능

> 출시 기간 : 2024.05.13 ~ 2024.05.27

업비트 데이터를 웹소켓을 활용해 가상화폐의 실시간 거래 품목, 누적대금 등의 데이터를 받아와 보여주는 어플리케이션

<br>

## 주요 기능
### 가상화폐 실시간 등락
> 웹소켓을 통해 실시간으로 변동하는 가격 확인 가능

### 가상화폐 정렬
> 현재가, 전일대비, 누적대금을 내림차순 또는 오름차순으로 정렬하여 데이터를 볼 수 있음

<br>

## 기술 스택

`UIKit(CodeBase)` / `SwiftUI` <br>
`Diffable DataSource` /  `PinLayout` / `FlexLayout` <br>
`RxSwift` / `Combine` / `MVVM` <br>

### 트러블 슈팅

#### app이 background에서 foreground으로 돌아올 때 layout이 안잡히는 현상

#### ❗문제 상황

flex와 pin을 적용하자 background -> foreground 과정에서 Layout이 안잡히는 현상 발생

#### ❗️ 원인파악

prepareToReuse에 다시 cell의 layout을 다시 잡아줄 경우 스크롤 시 해당 부분의 Layout은 다시 잡힘

결과적으로 background -> foreground 과정에서 레이아웃이 해제되는 것으로 파악

#### ❗해결 방법

-> sceneDelegate에 foreground를 확인할 타입 프로퍼티 클로저를 생성
-> sceneDelegate의 sceneWillEnterForeground를 통해서 클로저를 실행
-> marketsViewController에서 클로저에 tableView reload를 시퀀스로 넣어줌

foreground로 돌아오게 될 때 클로저가 실행되며 다시 레이아웃을 잡아주고 해결


### 수 많은 UI 업데이트로 인한 버벅임

웹소켓 통해 데이터를 지속적으로 받아오며 tableview cell를 매번 새로 그려주다보니 task stack이 많이 쌓여 스크롤시 버벅임 발생

#### ❗️ 해결방법

1. main thread에서 동작하는 걸 global queue로 변경해서 mainthread의 부담 줄이기

2. debounce로 받아오는 이벤트 횟수 줄이기
 -> debounce보다는 간격별로 확실한 업데이트가 가능한 throttle이 적절하여 변경

4. rxdatasource -> diffable (snapshot 방식으로 변경된 데이터만 ui 업데이트)

<img src = "https://github.com/DONOTINTO/DoT/assets/123792519/b0be60ac-d869-4f86-9140-0f4a8c8eef72">

<img src = "https://github.com/DONOTINTO/DoT/assets/123792519/55dbe1f3-a38f-4bf8-9753-328f70ec1774">


1. global queue

메인스레드 부담 97.4 -> 92.7 약 4.7%p 줄임
하지만 아직도 스크롤 시 버벅임 발생


### Animation 사이드 이펙트

-> 스크롤 버벅임은 사라졌지만 ui가 업데이트되면서 글자가 겹치는 현상 발생
-> 너무 빈번한 ui업데이트가 문제인가 싶엇음
    -> throttle로 업데이트 속도 늦춰봄 -> 해결안됨
    -> 서버에서 decoding 하는 데이터 수를 줄여서 최대한 변경사항을 줄여서 snapshot으로 변경사항 줄이기 -> 해결안됨

-> diffable update animation이 문제였음
-> 스크롤 시 한번씩 터치가 씹히는 현상도 개선됨
