# swift-w5-shopping
모바일 5주차 쇼핑 저장소
# 21.02.06
1. 네트워크 기능 분리
2. detail View 생성 -> 기존 detailVC에서 구현되어 있던 기능 모두 분리
3. json 로딩 및 디코딩 실패하거나, 구매버튼 클릭 noti 받을 시 Toast 출력 후 이전 화면으로 전환
4. pagingScrollView 구현
5. 데이터 전달 방식 수정
6. 전체적인 구조 조정

# 21.02.04

1. 상세화면 - detailViewController 생성
2. 데이터 전송 및 Json 파일 디코딩
3. 스크롤 뷰 및 웹 뷰 등 여러 속성 표시 
4. 레이아웃 설정

<결과 영상>

https://user-images.githubusercontent.com/59315024/106902803-9165d200-673c-11eb-933e-bfecc442b876.mov


# 21.02.03
1. 피드백 내용 수정 및 기능 추가
2. DetailViewController 추가 및 Segue 설정

# 21.02.02
1. 섹션 헤더 구현
2. 셀 터치시 정보 Toast 형태로 출력
3. URL을 통한 이미지 다운로드
4. 캐시 디렉토리 검색 및 저장 기능

<결과 화면>


https://user-images.githubusercontent.com/59315024/106612012-f50cc580-65ab-11eb-9297-8291cf5e151d.mov
 
  
# 21.02.01
1. HTTP 프로토콜 GET 요청으로 JSON 데이터 받아오기
  1-1. URLSession 사용
2. 응답으로 받은 JSON 데이터 Decoding 하여 StoreItem 객체로 변환
  2-1. 비동기 방식을 위한 Async 사용
  2-2. StoreItem은 Decodable 프로토콜 채택
3. ViewContoller 에 CollectionView 및 Custom cell 구성
4. Url을 통해 이미지 가져오기
  4-1. Async
5. StoreItem 데이터 CollectionView Cell 저장 및 View에 표시
6. autolayout 작업중~

<결과 화면>

<img width="300"  src="https://user-images.githubusercontent.com/59315024/106462255-2ff1f900-64d9-11eb-9e5d-fd466e840769.png">

