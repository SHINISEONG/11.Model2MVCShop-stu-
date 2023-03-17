<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   
   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip 사용 JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
		//=============    검색 / page 두가지 경우 모두  Event  처리 =============	
		function fncGetPurchseList(currentPage) {
			$("#currentPage").val(currentPage)
			$("form").attr("method" , "POST").attr("action" , "listPurchase").submit();
		}
		
		
		
		//============= tranNo 에 구매정보보기 Event 처리(Click) =============
		$(function() {
			
			
			
			$( "td:nth-child(1)" ).on("click" , function() {
				
				var tranCode = $(this).children('input:hidden').val()
				
				if(tranCode <= 3){
					self.location ="getPurchase?tranNo="+$(this).text().trim();
				} else if(tranCode >= 6) {
					self.location ="listMultiplePurchaseProd?cartTranNo="+$(this).text().trim();
				}
				
			});
						
			$( "td:nth-child(1)" ).css("color" , "blue");
			
			
			
		});	
		//============= userId 에 회원정보보기 Event 처리(Click) =============	
		$(function() {
		
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "td:nth-child(2)" ).on("click" , function() {
				 self.location ="/user/getUser?userId="+$(this).text().trim();
			});
						
			//==> userId LINK Event End User 에게 보일수 있도록 
			$( "td:nth-child(2)" ).css("color" , "red");
			
		});	
		
		
			
			//============= "배송"  Event  처리 =============	
			 $(function() {
				 $( "td:contains('배송하기')" ).on("click" , function() {
						self.location ="updateTranCode?tranNo="+$(this).children('input:hidden').val()+"&tranCode=2&page=${resultPage.currentPage}";
				 });
					
				 $( "td:contains('물건도착')" ).on("click" , function() {
						self.location ="updateTranCode?tranNo="+$(this).children('input:hidden').val()+"&tranCode=3&page=${resultPage.currentPage}";
				 });
			 });
			
		
		
		
	</script>
	
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
	       <h3>구매내역조회</h3>
	    </div>
	    
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0" ${ search.searchCondition == 0 ?" selected":""}>주문번호</option>
						<c:if test = "${user.role eq 'admin'}">
							<option value="1" ${ search.searchCondition == 1 ?" selected":""}>유저ID</option>
						</c:if>
						<option value="2" ${ search.searchCondition == 2 ?" selected":""}>구매자명</option>
						<option value="3" ${ search.searchCondition == 3 ?" selected":""}>주문날짜</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">검색</button>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table 위쪽 검색 Start /////////////////////////////////////-->
		
		
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="left">주문번호</th>
            <th align="left">회원 ID</th>
            <th align="left">구매자명</th>
            <th align="left">전화번호</th>
            <th align="left">배송현황</th>
            <th align="left">정보수정</th>
          </tr>
        </thead>
       
		<tbody>
			
		  <c:set var="i" value="0" />
		  <c:forEach var="purchase" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center" title="Click : 주문정보 확인" class = "code${purchase.tranCode}">
			  <input type="hidden" value= "${purchase.tranCode}" />
			  	${purchase.tranNo}
			  </td>
			  <td align="left"  title="Click : 회원정보 확인">${purchase.buyer.userId}</td>
			  <td align="left">${purchase.receiverName}</td>
			  <td align="left">${purchase.receiverPhone}</td>
			  <td align="left">
			  	<c:if test="${!(purchase.tranCode eq '0')}">
				현재
				<c:choose>
					<c:when test ="${purchase.tranCode eq '1' || purchase.tranCode eq '8'}">
						구매완료
					</c:when>
				
					<c:when test ="${purchase.tranCode eq '2' || purchase.tranCode eq '7'}">
						배송중
					</c:when>
					
					<c:when test ="${purchase.tranCode eq '3' || purchase.tranCode eq '6'}">
						배송완료
					</c:when>
				</c:choose>
				 상태 입니다.
				</c:if>
			  </td>
			  
			  <td align="left">
			  	
			  <c:if test = "${(purchase.tranCode eq '1' || purchase.tranCode eq '8' )&& user.role eq 'admin' }">
					<input type="hidden" value= "${purchase.tranNo}"/>
					배송하기
				</c:if>
				
				<c:if test = "${(purchase.tranCode eq '2' || purchase.tranCode eq '7') && user.role eq 'user'}">
					<input type="hidden" value= "${purchase.tranNo}"/>
					물건도착
				</c:if>
				
			  </td>
			  
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>

</html>