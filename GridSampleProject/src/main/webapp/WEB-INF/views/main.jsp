<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>jqGrid page</title>
	<!-- jQuery, bootstrap CDN -->
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="http://code.jquery.com/jquery-migrate-1.2.1.js"></script> <!-- msie 문제 해결 -->
	<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/latest/js/bootstrap.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/latest/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap.min.css">
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
	<!-- jqGrid CDN & paging -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqgrid/4.6.0/css/ui.jqgrid.css" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jqgrid/4.6.0/js/jquery.jqGrid.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jqgrid/4.6.0/js/i18n/grid.locale-en.js"></script>
	<script src="/js/util/paginate.js"></script>
	<!-- Zebra Dialog -->
	<script src="/js/dialog/zebra_dialog.src.js"></script>
	<link rel="stylesheet" href="/css/dialog/zebra_dialog.css" type="text/css"/>
</head>
<body>
	<h1># jqGrid Test Page</h1>
	<br>
	<button id="refresh"><img src='/images/refreshbutton.PNG' width='50' height='50'></button>&nbsp
	<select name="rownumselect" onchange="setValues(this.value);">
    	<option value="2">rowNum</option>
    	<option value="1">1</option>
    	<option value="5">5</option>
    	<option value="10">10</option>
	</select>
	<br>
	<div>
		<table id="grid"></table>
	</div>
	<br>
	<div id="paginate" class="pagenate" align="center">
	</div>
	<br>
	<div>
		<label>* Click Multi Select Info</label><br>
		<input type='button' value='click' id='multicellinfobutton'>
	</div>
	<br>
	<div>
		<label>* Search Info</label><br>
		<input type="text" placeholder="input search name" id="searchtext">&nbsp
		<input type="button" value="search(table reload)" id="searchbutton">&nbsp
		<input type="button" value="refresh" id="refreshbutton">
	</div>
	<br>
	<div>
		<label>* Mail info</label><br>
		<input type="text" placeholder="input send mailaddress" id="sendtoaddress">&nbsp
		<input type="text" placeholder="input email subject" id="emailsubject">&nbsp
		<input type="text" placeholder="input email content" id="emailcontent">
		<input type="button" value="메일전송" id="sendmailbtn">
	</div>
</body>
<script type="text/javascript">
$(function(){
	//Grid에서 멀티체크 확인(PK의 구분을 가진 데이터를 활용)//
	$('#multicellinfobutton').click(function(){
		var selectnumber = $("#grid").jqGrid('getGridParam','selarrrow');
		
		var infodialog = new $.Zebra_Dialog('<strong>Message:</strong><br><br><p>선택된 번호: '+selectnumber + '</p>',{
			title: 'jqGrid Test',
			type: 'confirmation',
			print: false,
			width: 760,
			position: ['right - 20', 'top + 20'],
			buttons: ['닫기'],
			onClose: function(caption){
				if(caption == '닫기'){
					//alert('yes click');
				}
			}
		});
	});
	//Grid에서 검색 및 테이블 리로드//
	$('#searchbutton').click(function(){
		$('#grid').jqGrid('setGridParam', {
			search:true,
			datatype:"json",
			loadonce:true,
			postData:{
				name : $('#searchtext').val() //조건값 설정//
			},
			page : 1
		}).trigger('reloadGrid');
	});
	//Grid 새로고침//
	$('#refresh').click(function(){
		$("#grid").jqGrid('GridUnload'); //그리드를 전체 지운다.//
		
		datainit(); //재로드//
	});
	$('#sendmailbtn').click(function(){
		//ajax//
		var sendto = $('#sendtoaddress').val();
		var subject = $('#emailsubject').val();
		var content = $('#emailcontent').val();
		
		var trans_objeect = 
		{
	    	'sendto':sendto,
	    	'subject':subject,
	    	'content':content
	    }
		var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
		
		$.ajax({
			url: '<c:url value="/sendmail.do"/>',
			type: 'POST',
			dataType: 'json',
			data: trans_json,
			contentType: 'application/json',
			mimeType: 'application/json',
			success: function(retVal){
				var infodialog = new $.Zebra_Dialog('<strong>Message:</strong><br><br><p>ajax call '+retVal.result+'</p>',{
					title: 'jqGrid Test',
					type: 'confirmation',
					print: false,
					width: 760,
					position: ['right - 20', 'top + 20'],
					buttons: ['닫기'],
					onClose: function(caption){
						if(caption == '닫기'){
							//alert('yes click');
						}
					}
				});
			},
			error: function(retVal, status, er){
				alert("error: "+retVal+" status: "+status+" er:"+er);
			}
		});
	});
});
</script>
<script type="text/javascript">
$(function(){
	datainit(); //Grid 초기화//
});
///////////////////////////
function datainit(){
	//jqGrid Setting//
	$('#grid').jqGrid({
		url:'<c:url value="/datalist.do"/>',
		mtype:'POST',
		datatype:"json",
		height:'auto',
		width:'auto',
		autowidth:true,
		rowNum:2,
		pager:'#pager',
		loadonce:true,
		colModel:[
         	{label:'No',name:'id',index:'id', width:50, sortable:true},
         	{label:'Password',name:'password',index:'password', width:50, hidden:true},
            {label:'Name',name:'name',index:'name', width:50, formatter:detailinfo},
            {label:'EmpNum',name:'empnum',index:'empnum', width:50, align:"right"},
            {label:'정보보기', name:'info', index:'info', width:50, formatter:infoclick}
        ],
        multiselect:true,
		caption:"<label>* 총 <strong id='totalCnt'>0</strong>건의 검색결과가 있습니다.</label>",
		loadComplete:function(data){
			//그리드 로드가 종료된 후 실행//
			$('#totalCnt').text(data.records);
			//페이징 작업(loadonce가 true가 되야지 페이징 가능 = sort도 동일)//
			initPage("paginate", data.records, $('#grid').jqGrid("getGridParam", "rowNum"), data.page);
		}
	});
	
	// 로컬 데이터
	/*var data = [];

    data = [
        {id:"1",name:"서창욱",empnum:"21084", password:'1234'},
       	{id:"2",name:"홍길동",empnum:"21085", password:'5678'},
       	{id:"3",name:"임꺽정",empnum:"21086", password:'1425'},
       	{id:"4",name:"김철수",empnum:"21087", password:'1111'},
       	{id:"5",name:"김영희",empnum:"21088", password:'2222'},
    ];
	
	var datasize = data.length;

    for( i=0; i<datasize; i++){
    	$('#grid').jqGrid('addRowData', i+1, data[i]); //컬럼에 데이터 추가//
    }*/
    
    console.log('data load success...');
}
//////////////////////////
function infoclick(cellvalue, options, rowdata, action){
	//테이블 내 버튼을 출력//
	return "<input type=\"button\" value=\"click\" onclick=\"info('"+rowdata.name+"','"+rowdata.empnum+"','"+rowdata.password+"')\"/>";
}
//////////////////////////
function info(name, empnum, password){
	console.log('------------------------');
	console.log('cell info print');
	console.log('name: ' + name);
	console.log('empnum: ' + empnum);
	console.log('password: ' + password);
	console.log('------------------------');
	
	//ajax//
	var v_name = name;
	var v_empnum = empnum;
	var v_password = password;
	
	var trans_objeect = 
	{
    	'name':v_name,
    	'empnum':v_empnum,
    	'password':v_password
    }
	var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
	
	$.ajax({
		url: '<c:url value="/datainfo.do"/>',
		type: 'POST',
		dataType: 'json',
		data: trans_json,
		contentType: 'application/json',
		mimeType: 'application/json',
		success: function(retVal){
			var infodialog = new $.Zebra_Dialog('<strong>Message:</strong><br><br><p>ajax call success</p>',{
				title: 'jqGrid Test',
				type: 'confirmation',
				print: false,
				width: 760,
				position: ['right - 20', 'top + 20'],
				buttons: ['닫기'],
				onClose: function(caption){
					if(caption == '닫기'){
						//alert('yes click');
					}
				}
			});
		},
		error: function(retVal, status, er){
			alert("error: "+retVal+" status: "+status+" er:"+er);
		}
	});
}
//////////////////////////
function detailinfo(cellvalue, options, rowdata, action){
	//테이블 내 링크로 출력('javascript:'로 해야지 일반 페이지 이동이 되지 않고 자바스크립트 함수를 호출 가능)//
	return "<a href=\"javascript:detaildialog('"+rowdata.name+"')\">"+cellvalue+"</a>";
}
//////////////////////////
function detaildialog(name){
	var infodialog = new $.Zebra_Dialog('<strong>Message:</strong><br><br><p>detail info: '+name+'</p>',{
		title: 'jqGrid Test',
		type: 'confirmation',
		print: false,
		width: 760,
		position: ['right - 20', 'top + 20'],
		buttons: ['닫기'],
		onClose: function(caption){
			if(caption == '닫기'){
				//alert('yes click');
			}
		}
	});
}
///////////////////////////
//페이지 이동(Search)//
function Search(searchPage){
	console.log('page['+searchPage+'] search...');
	
	$('#grid').jqGrid('setGridParam',{
		search:true,
		page:searchPage,
	}).trigger('reloadGrid');
}
///////////////////////////
//select 박스 선택 이벤트//
function setValues(rowNum){
	console.log('select rowNum : ' + rowNum);
	
	//변경된 rowNum에 따라 호출//
	$('#grid').jqGrid('setGridParam', {
		page : 1,
		rowNum:rowNum,
	}).trigger('reloadGrid');
}
</script>
</html>