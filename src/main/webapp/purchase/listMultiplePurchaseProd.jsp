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
	$(()=>{
		$('.btn-primary').on('click', ()=>{
			$('form').attr('action','addMultiplePurchase').attr('method','get').submit();
		});
	})
	</script>
	
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
	       <h3>주문조회</h3>
	    </div>
	    
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    	    <%--
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
		  --%>
		
      <!--  table Start /////////////////////////////////////-->
      <form>
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="left">No</th>
            <th align="left">상품명</th>
            <th align="left">가격</th>
            <th align="left">구매 수량</th>
          </tr>
        </thead>
       
		<tbody>
			
		  <c:set var="i" value="0" />
		  <c:forEach var="product" items = "${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="left">${i }</td>
			  <td align="left">${product.prodName}</td>
			  <td align="left">${product.price }</td>
			  <td align="left">
			  	${product.cartQuantity}
			  	
			  	</td>
			  <td>
			  	<input type="hidden" name="prodNo" value ="${product.prodNo }"/>
			  	<input type="hidden" name="cartTranNo" value = "${search.cartTranNo }"/>
			  </td>
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
      </form>
	  <!--  table End /////////////////////////////////////-->
	  <c:if test="${purchase.tranCode eq '8' }">
	  	<button type="button" class="btn btn-primary">수정</button>
	  </c:if>
	  
	  <button type="button" class="btn btn-default">확인</button>
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<%--<jsp:include page="../common/pageNavigator_new.jsp"/> --%>
	<!-- PageNavigation End... -->
	
</body>

</html>