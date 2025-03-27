<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
	<%@ include file="../include/header.jsp" %>		                                                                                        
	
			<div class='container mt-5'>                                                                        
				<h2>회원 리스트</h2>  
				<!-- --------------------------------------------------------------------------------------- -->
		    	<div>
					<form action="memberList.do" id="searchForm" method="post">
						<!-- 선택된 목록개수를 검색클릭시 넘겨줌 -->
			    		<input type="hidden" name="cntPerPage" value="${pDto.cntPerPage}">
		    		     
						<div class="d-flex justify-content-center">
							<select class="form-select form-select-sm me-2" style="width:200px" 
										name="searchType">
								<option value="">선택</option>
								<option value="I" ${pDto.searchType == 'I' ? 'selected':''}>아이디</option>
								<option value="N" ${pDto.searchType == 'N' ? 'selected':''}>이름</option>
								<option value="E" ${pDto.searchType == 'E' ? 'selected':''}>이메일</option>
							</select>
							<input type="text" id="keyword" name="keyword" placeholder="검색어입력"
								class="form-control rounded-0 rounded-start" style="width:300px" 
								value="${pDto.keyword}">
							<button class="btn rounded-0 rounded-end" style="background:#1384aa; color:white"><i class="fa fa-search"></i></button>
						</div>
					</form>
				</div>
				
				<div class="d-flex my-3 justify-content-between">
					<div><b>${pDto.viewPage}</b> / ${pDto.totalPage} pages</div>
					
					<!-- 검색이 없는 경우 -->
					<c:if test="${pDto.searchType == null || pDto.searchType ==''}">
				  	<div>
			      		<select class="form-select form-select-sm" id="cntPerPage">
							<option value="5" ${pDto.cntPerPage == 5 ? 'selected':''}>회원 5명</option>
			      			<option value="10" ${pDto.cntPerPage == 10 ? 'selected':''}>회원 10명</option>
			      			<option value="20" ${pDto.cntPerPage == 20 ? 'selected':''}>회원 20명</option>      		
			      		</select>
			      	</div>
			      	</c:if>
			      	<!-- 검색한 경우 경우 -->
					<c:if test="${pDto.searchType != null && pDto.searchType !=''}">
						<div>
						<select class="form-select form-select-sm" id="cntPerPage">
			      			<c:choose>
			      				<c:when test="${pDto.totalCnt <= 5}">
			      					<option value="5" ${pDto.cntPerPage== 5 ? 'selected':''}>선택없음</option>
			      				</c:when>
			      				
			      				<c:when test="${pDto.totalCnt > 5 && pDto.totalCnt < 10}">
			      					<option value="5" ${pDto.cntPerPage== 5 ? 'selected':''}>회원 5명</option>
					      			<option value="10" ${pDto.cntPerPage== 10 ? 'selected':''}>회원 10명</option>
			      				</c:when>
			      				
<%-- 			      				<c:when test="${pDto.totalCnt >=10 && pDto.totalCnt < 20}">
			      					<option value="5" ${pDto.cntPerPage== 5 ? 'selected':''}>회원 10명</option>
					      			<option value="10" ${pDto.cntPerPage== 10 ? 'selected':''}>회원 20명</option>
			      				</c:when> --%>
			      				
			      				<c:otherwise>
			      					<option value="5" ${pDto.cntPerPage== 5 ? 'selected':''}>회원 5명</option>
					      			<option value="10" ${pDto.cntPerPage== 10 ? 'selected':''}>회원 10명</option>
					      			<option value="20" ${pDto.cntPerPage== 20 ? 'selected':''}>회원 20명</option>
			      				</c:otherwise>
			      			</c:choose>
			      		</select>
			      		</div>
			      	</c:if>
				</div>
    	<!-- --------------------------------------------------------------------------------------------- -->                                                                          
				<table class='table'>                                                                           
					<thead class='table-dark'>                                                                  
						<tr>                                                                                    
							<th>번호</th>                                                                       
							<th>아이디</th>                                                                     
							<th>비밀번호</th>                                                                   
							<th>이름</th>                                                                       
							<th>나이</th>                                                                       
							<th>이메일</th>                                                                     
							<th>전화번호</th>                                                                   
							<th>삭제</th>                                                                       
						</tr>                                                                                   
					</thead>                                                                                    
					<tbody>                                                                                     
					                                                                                            
		
		<%-- <% for( UserDTO dto : list) { %> --%>
		<c:forEach var="dto" items="${list}">
			<tr>                                                                                             
				<%-- <td><%=dto.getUno()%></td> --%>                                                                
				<td>${dto.uno}</td>                                                                
<%-- 				<td><a href="<c:url value='memberInfo.do?uno=${dto.uno}&viewPage=${pDto.viewPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}'/>" >${dto.id}</a></td> --%>
				<td>
					<c:url var="infoUrl" value="memberInfo.do">
						<c:param name="uno" value="${dto.uno}"/>
						<c:param name="viewPage" value="${pDto.viewPage}"/>
						<c:if test="${not empty pDto.searchType}">
					        <c:param name="searchType" value="${pDto.searchType}" />
					    </c:if>
					    
					    <c:if test="${not empty pDto.keyword}">
					        <c:param name="keyword" value="${pDto.keyword}" />
					    </c:if>

						<c:param name="cntPerPage" value="${pDto.cntPerPage}"/>
					</c:url>
					
					<a href="${infoUrl}">${dto.id}</a>
				</td>
				
				<td>${dto.pw}</td>                                                                 
				<td>${dto.name}</td>                                                                   
				<td>${dto.age}</td>                                                                    
				<td>${dto.email}</td>                                                                  
				<td>${dto.tel}</td>                                                                    
				<td><a href="<c:url value='memberDelete.do?uno=${dto.uno}&viewPage=${pDto.viewPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}'/>" 
					class='btn btn-danger btn-sm'>삭제</a></td>                                                                                
			</tr>                                                                                            
		<%-- <% } %> --%>
			
		
		</c:forEach>
		</tbody>
		</table>
		
		    <!-- 페이지 네이션 -->
<%--    <ul class="pagination justify-content-center">
        <li class="page-item ${pDto.prevPage <=0 ? 'disabled':''}">
            <a class="page-link" href="memberList.do?viewPage=${pDto.prevPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}">이전</a>
        </li>

        <c:forEach var="i" begin="${pDto.blockStart}" end="${pDto.blockEnd}">
            <li class="page-item ${pDto.viewPage == i ? 'active':''}">
                <a class="page-link" href="memberList.do?viewPage=${i}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}">${i}</a>
            </li>
        </c:forEach>

        <li class="page-item ${pDto.blockEnd >= pDto.totalPage ? 'disabled':''}">
            <a class="page-link" href="memberList.do?viewPage=${pDto.nextPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}">다음</a> --%>
    
   <form id="paginationForm" action="memberList.do" method="get">
       <input type="hidden" name="viewPage" id="viewPage" value="${pDto.viewPage}">
       <input type="hidden" name="searchType" value="${pDto.searchType}">
       <input type="hidden" name="keyword" value="${pDto.keyword}">
       <input type="hidden" name="cntPerPage" value="${pDto.cntPerPage}">
   </form>        
            
    <ul class="pagination justify-content-center">
        <li class="page-item ${pDto.prevPage <=0 ? 'disabled':''}">
            <a class="page-link" href="#" data-page="${pDto.prevPage}">이전</a>
        </li>

        <c:forEach var="i" begin="${pDto.blockStart}" end="${pDto.blockEnd}">
            <li class="page-item ${pDto.viewPage == i ? 'active':''}">
                <a class="page-link" href="#"  data-page="${i}">${i}</a>
            </li>
        </c:forEach>

        <li class="page-item ${pDto.blockEnd >= pDto.totalPage ? 'disabled':''}">
            <a class="page-link" href="#"  data-page="${pDto.nextPage}">다음</a>
        </li>
    </ul>
	</div>	
<script>
	// 이벤트 위임
	$(".page-item").on("click", ".page-link", function (e) {
	    e.preventDefault(); // 기본 동작 방지 a 태그의 링크 이벤트 막아줌
	    $("#viewPage").val($(this).data("page")); // this는 이벤트가 발생하는 대상(.page-link)
	    $("#paginationForm").submit();
	});

/* 	$("#cntPerPage").change(() => {
	    var cntVal = $("#cntPerPage").val();
	    alert(cntVal);
	    
	    location.href="memberList.do?viewPage=1&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage="+cntVal;
 	}); */
 	
 	$("#cntPerPage").change(() => {
	    var cntVal = $("#cntPerPage").val();
	    alert(cntVal);
	    
	    // window.location.search ==> 쿼리스트링만 가져옴 ?viewPage=1&searchType=&keyword=&cntPerPage=10
	 	let params = new URLSearchParams(window.location.search);
	    params.set("viewPage", 1);  // 파라미터 셋팅
	    params.set("cntPerPage", cntVal);
	
	    // 불필요한 파라미터 제거
	    if (!params.get("searchType")) params.delete("searchType");
	    if (!params.get("keyword")) params.delete("keyword");

	    location.href = "memberList.do?" + params.toString();
 	});

</script>
				                                                                                                  
</body>                                                                                                 
</html>                        
