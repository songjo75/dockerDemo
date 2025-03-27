<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<div class="container w-50 mt-5 p-5 shadow">
	<div class="d-flex w-100">
    	<h4>글 상세보기</h4><button class="btn btn-sm btn-outline-danger like-btn ms-auto" data-bid="${dto.bid}">♥ ${dto.likes}</button>
    </div>
    
    <div class="form-group">
        <label for="bid">번호</label>        
        <input class="form-control" type="text" id="bid" 
            name="bid" value="${dto.bid}" disabled >
    </div> 
    <div class="form-group">
        <label for="subject">제목</label>     
        <input class="form-control" type="text" id="subject" 
            name="subject" value="<c:out value='${dto.subject}'/>" disabled />      
    </div>
    <div class="form-group">
        <label for="contents">내용</label>
        <textarea class="form-control mt-2" 
            name="contents" id="contents" disabled>${dto.contents}</textarea>
    </div>
    <div class="form-group">
        <label for="writer">글쓴이</label>
        <input class="form-control mt-2" type="text" 
            id="writer" name="writer" value="${dto.writer}" disabled />
    </div>
    <div class="form-group">
        <label>등록/수정일</label>
        <input class="form-control" type="text" 
            value="<fmt:formatDate value='${dto.modify_date != null ? dto.modify_date : dto.reg_date}' 
            pattern='yyyy-MM-dd HH:mm'/>" disabled />
    </div>
    <div class="form-group">
        <label>조회수</label>
        <input class="form-control" type="text" value="${dto.hit}" disabled />
    </div>

    <div class="text-center mt-3">
        <button id="btn-modify" class="btn btn-primary me-2">수정하기</button>   
        <button id="btn-list" class="btn btn-primary me-2">리스트</button>  
    </div>
</div>
<script>
	$("#btn-list").click(() => {
	    location.href = "<c:url value='list.do?viewPage=${pDto.viewPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}'/>";
	});

	$("#btn-modify").click(() => {
	    location.href = "<c:url value='modify.do?bid=${dto.bid}&viewPage=${pDto.viewPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}'/>";
	});
	
	// 좋아요 버튼 클릭
	$(".like-btn").click(function(){
		let bid = $(this).data("bid");
		let btn = $(this);
		
		$.ajax({
			url: "like.do",
			type:"get",
			data:{bid:bid},
			success:function(response){
				alert(response);
				if(response === "success"){
					let currentLikes = parseInt(btn.text().trim().replace("♥",""));
					btn.text("♥ "+ (currentLikes + 1));					
				}
			},
			error:function(){alert("좋아요 추가 실패!!");}
		});
	});
</script>
