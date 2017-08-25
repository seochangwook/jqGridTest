function initPage(pager, totCount, rowCount, page){
	//한 페이지에 보여줄 페이지 수(1,2,3,4...)//
	var pageCount = 10;
	//현재 페이지 설정//
	var page = parseInt(page);
	//그리드 데이터 전체의 페이지 수//
	var totalPage = Math.ceil(totCount/rowCount);
	//전체 페이지 수를 한 화면에 보여줄 페이지로 나눈다.//
	var totalPageList = Math.ceil(totalPage / pageCount);
	//페이지 리스트가 몇번째 리스트인지//
	var pageList = Math.ceil(page/pageCount);
	
	//페이지 리스트가 1보다 작으면 1로 초기화//
	if(pageList<1){
		pageList = 1;
	}
	
	//페이지 리스트가 총 페이지 리스트보다 커지면 총 페이지 리스트로 설정//
	if(pageList > totalPageList){
		pageList = totalPageList;
	}
	
	//시작페이지//
	var startPageList = ((pageList-1) * pageCount) + 1;
	//끝 페이지//
	var endPageList = startPageList + pageCount - 1;
	
	//시작페이지와 끝 페이지가 1보다 작으면 1로 설정//
	//끝 페이지가 마지막 페이지보다 클 경우 마지막 페이지 값으로 설정//
	if(startPageList < 1){
		startPageList = 1;
	} 
	
	if(endPageList > totalPage){
		endPageList = totalPage;
	}
	
	if(endPageList < 1){
		endPageList = 1;
	}
	
	var perPage = 1;
	
	if(page > 1){
		perPage = page - 1;
	}
	
	var nextPage = page + 1;
	
	//페이징 DIV에 넣을 태그 생성변수//
	var pageInner = "";
	
	//페이지 리스트가 1이나 데이터가 없을 경우 (링크빼고 흐린 이미지로 변경)//
	if(pageList < 2){
		if(1 < page){
			pageInner += "<a class='pre' href='javascript:Search(1)'><img src='/images/paging/btn_first.PNG' width='50' height='50'></a>";
			pageInner += "<a class='pre' href='javascript:Search("+perPage+")'><img src='/images/paging/btn_prev.PNG' width='50' height='50'></a>";
		} else {
			pageInner += "<img src='/images/paging/btn_first_off.PNG' width='50' height='50'>";
			pageInner += "<img src='/images/paging/btn_prev_off.PNG' width='50' height='50'>";
		}
	}
	
	//이전 페이지 리스트가 있을 경우 (링크넣고 뚜렷한 이미지로 변경)//
	if(pageList > 1){
		pageInner += "<a class='first' href='javascript:Search(1)'><img src='/images/paging/btn_first.PNG' width='50' height='50'></a>";
		pageInner += "<a class='pre' href='javascript:Search("+perPage+")'><img src='/images/paging/btm_prev.PNG' width='50' height='50'></a>";
	}
	
	//페이지 숫자를 찍으며 태그생성 (현재 페이지는 강조태그)//
	for(var i=startPageList; i<= endPageList; i++){
		if(i == page){
			pageInner = pageInner + "<strong>"+(i)+"</strong>";
		} else{
			pageInner = pageInner + "<a href='javascript:Search("+(i)+")' id='"+(i)+"'>"+(i)+"</a>";
		}
	}
	
	//다음 페이지 리스트가 있을 경우//
	if(totalPageList > pageList){
		pageInner += "<a class='next' href='javascript:Search("+nextPage+")'><img src='/images/paging/btn_next.PNG' width='50' height='50'></a>"
		pageInner += "<a class='last' href='javascript:Search("+totalPage+")'><img src='/images/paging/btn_last.PNG' width='50' height='50'></a>"
	}
	
	//현재 페이지리스트가 마지막 페이지 리스트일 경우//
	if(totalPageList == pageList){
		if(totalPage > page){
			pageInner += "<a class='next' href='javascript:Search("+nextPage+")'><img src='/images/paging/btn_next.PNG' width='50' height='50'></a>"
			pageInner += "<a class='last' href='javascript:Search("+totalPage+")'><img src='/images/paging/btn_last.PNG' width='50' height='50'></a>"
		} else{
			pageInner += "<img src='/images/paging/btn_next_off.PNG' width='50' height='50'>";
			pageInner += "<img src='/images/paging/btn_last_off.PNG' width='50' height='50'>";
		}
	}
	
	//페이징할 diV태그에 우선 내용을 비우고 페이징 태그삽입//
	$("#"+pager).html("");
	$("#"+pager).html(pageInner);
}
/////////////////////////////////