# jqGridTest

<div>
<label>* http://www.trirand.com/blog/</label><br>
<label>* http://www.trirand.com/blog/jqgrid/jqgrid.html</label><br>
<label>* http://blog.naver.com/PostView.nhn?blogId=jaeik714&logNo=140187085974</label>
<h2>$ jqGrid - Grid Option</h2>
<li>datatype : 그리드에 표시할 데이터 타입 xml, json, local등을 사용</li>
<li>height : Body부분의 사이즈를 지정. 'auto'로 지정 시 데이터 갯수에 따라 자동으로 높이를 계산</li>
<li>colNames : 컬럼명을 지정</li>
<li>colModel : 각각의 컬럼에 대한 속성을 정의. 그리드에서 가장 중요 속성 중 하나</li>
<li>multiselect : 멀티셀렉트 여부결정. true지정 시 컬럼 맨 앞에 checkbox표시. 여러 행 선택가능</li>
<li>caption : caption영역에 제목표시</li>
<li>url : 데이터를 획득을 위한 url</li>
<li>rowNum : 초기화면에 출력할 데이터 row개수</li>
<li>mtype : HTTP Request Method지정</li>
<h2>$ jqGrid - colModel Option</h2>
<li>name : 해당 column에 출력해야할 데이터 이름. 서버로 부터 넘어오는 데이터 이름, 데이터를 자동매핑</li>
<li>index : 정렬 시 사용할 이름을 지정. 미지정 시 정렬 시 name 속성을 사용</li>
<li>key : 유일한 row id값을 위해 id값으로 지정. 유일한 값</li>
<li>width : 컬럼의 너비를 픽셀단위로 지정. 퍼센트로 지정불가</li>
<li>align : Body부분의 셀 속성 정의. left, center, right정의</li>
<li>hidden : 컬럼의 숨김여부를 정의</li>
<li>format : 컬럼데이터의 format을 설정</li>
<li>formatter : 컬럼에 대한 이벤트 처리 함수 지정</li>
