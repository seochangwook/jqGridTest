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
	<br>
	<div>
		<label>* Click Multi Select Info</label><br>
		<input type='button' value='click' id='multicellinfobutton'>
	</div>
	<br>
	<div>
		<label>* Search Info</label><br>
		<input type="text" placeholder="input search Inv no" id="searchtext">&nbsp
		<input type="button" value="search(table reload)" id="searchbutton">
	</div>
</body>
<script type="text/javascript">
//데이터 초기화 및 스크립트 초기화//
console.log('script load success...');

$(function(){
	//Grid에서 멀티체크 확인//
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
				id : $('#searchtext').val()
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
		 datatype : "local",
		 height : 'auto',
		 autowidth : true,
		 colModel:[
         	{label:'Inv No',name:'id',index:'id', width:60, sorttype:"int", sortable:false},
            {label:'Date',name:'invdate',index:'invdate', width:90, sorttype:"date"},
            {label:'Client',name:'name',index:'name', width:100},
            {label:'Amount',name:'amount',index:'amount', width:80, align:"right",sorttype:"float"},
            {label:'Tax', name:'tax',index:'tax', width:80, align:"right",sorttype:"float"},
            {label:'Total', name:'total',index:'total', width:80,align:"right",sorttype:"float"},
            {label:'Notes',name:'note',index:'note', width:150, sortable:false},
            {label:'정보보기', name:'info', index:'info', width:50, sortable:false, formatter:infoclick}
         ],
         multiselect: true,
		 caption: "그리드 배열 데이터 샘플링"
	});
	
	datainit(); //로컬데이터 초기화//
});
///////////////////////////
function datainit(){
	console.log('data load success...');
	// 로컬 데이터
    myData = [
        {id:"1",invdate:"2007-10-01",name:"test1",note:"note",amount:"200.00",tax:"10.00",total:"210.00"},
        {id:"2",invdate:"2007-10-02",name:"test2",note:"note2",amount:"300.00",tax:"20.00",total:"320.00"},
        {id:"3",invdate:"2007-09-01",name:"test3",note:"note3",amount:"400.00",tax:"30.00",total:"430.00"},
        {id:"4",invdate:"2007-10-04",name:"test4",note:"note",amount:"200.00",tax:"10.00",total:"210.00"},
        {id:"5",invdate:"2007-10-05",name:"test5",note:"note2",amount:"300.00",tax:"20.00",total:"320.00"},
        {id:"6",invdate:"2007-09-06",name:"test6",note:"note3",amount:"400.00",tax:"30.00",total:"430.00"},
        {id:"7",invdate:"2007-10-04",name:"test7",note:"note",amount:"200.00",tax:"10.00",total:"210.00"},
        {id:"8",invdate:"2007-10-03",name:"test8",note:"note2",amount:"300.00",tax:"20.00",total:"320.00"},
        {id:"9",invdate:"2007-09-01",name:"test9",note:"note3",amount:"400.00",tax:"30.00",total:"430.00"}
    ];

    for( i=0, max = myData.length ; i<=max ; i++ ){
    	$('#grid').jqGrid('addRowData', i+1, myData[i]); //컬럼에 데이터 추가//
    }
}
//////////////////////////
function infoclick(cellvalue, options, rowdata, action){
	//버튼을 출력//
	return "<input type=\"button\" value=\"click\" onclick=\"info('"+rowdata.invdate+"','"+rowdata.name+"')\"/>";
}
//////////////////////////
function info(invdate, name){
	console.log('------------------------');
	console.log('cell info print');
	console.log('invdate: ' + invdate);
	console.log('name: ' + name);
	console.log('------------------------');
	
	//ajax//
	var v_invdate = invdate;
	var v_name = name;
	
	var trans_objeect = 
	{
    	'invdate':v_invdate,
    	'name':v_name
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
</script>
</html>