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
	<!-- jqGrid CDN -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqgrid/4.6.0/css/ui.jqgrid.css" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jqgrid/4.6.0/js/jquery.jqGrid.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jqgrid/4.6.0/js/i18n/grid.locale-en.js"></script>
	<!-- Zebra Dialog -->
	<script src="/js/dialog/zebra_dialog.src.js"></script>
	<link rel="stylesheet" href="/css/dialog/zebra_dialog.css" type="text/css"/>
</head>
<body>
	<h1># jqGrid Test Page</h1>
	<br>
	<div>
		<table id="grid"></table>
	</div>
	<div id="pager" class="pagenate">
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
</body>
<script type="text/javascript">
//데이터 초기화 및 스크립트 초기화//
console.log('script load success...');

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
			postData:{
				name : $('#searchtext').val()
			},
			page : 1
		}).trigger('reloadGrid');
	});
});
</script>
<script type="text/javascript">
$(function(){
	//jqGrid Setting//
	$('#grid').jqGrid({
		datatype:"local",
		height:'auto',
		width:'auto',
		autowidth:true,
		rowNum:2,
		sortname:'id',
		sortorder:'desc',
		pager:'#pager',
		colModel:[
         	{label:'No',name:'id',index:'id', width:50, sorttype:"int", sortable:false},
         	{label:'Password',name:'password',index:'password', width:50, hidden:true, sorttype:"int", sortable:false},
            {label:'Name',name:'name',index:'name', width:50, formatter:detailinfo},
            {label:'EmpNum',name:'empnum',index:'empnum', width:50, align:"right",sorttype:"float"},
            {label:'정보보기', name:'info', index:'info', width:50, sortable:false, formatter:infoclick}
        ],
        multiselect:true,
		caption:"그리드 배열 데이터 샘플링",
		loadComplete:function(data){
			
		}
	});
	
	datainit(); //로컬데이터 초기화//
});
///////////////////////////
function datainit(){
	console.log('data load success...');
	var data = [];
	// 로컬 데이터
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
    }
    
    console.log('data load ')
}
//////////////////////////
function infoclick(cellvalue, options, rowdata, action){
	//버튼을 출력//
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
		url: "http://localhost:8080/ajaxtest",
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
	//링크로 출력(javascript로 해야지 일반 페이지 이동이 되지 않고 자바스크립트 함수를 호출 가능)//
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
</script>
</html>