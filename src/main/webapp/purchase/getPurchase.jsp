<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>상품조회</title>
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
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
     </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
<!--
function fncUpdateProduct(){
	//Form 유효성 검증
	var name = document.detailForm.prodName.value;
	var detail = document.detailForm.prodDetail.value;
	var manuDate = document.detailForm.manuDate.value;
	var price = document.detailForm.price.value;

	if(name == null || name.length<1){
		alert("상품명은 반드시 입력하여야 합니다.");
		return;
	}
	if(detail == null || detail.length<1){
		alert("상품상세정보는 반드시 입력하여야 합니다.");
		return;
	}
	if(manuDate == null || manuDate.length<1){
		alert("제조일자는 반드시 입력하셔야 합니다.");
		return;
	}
	if(price == null || price.length<1){
		alert("가격은 반드시 입력하셔야 합니다.");
		return;
	}
		

	$('form').attr('action','updateProduct').attr('method','post').attr('enctype','multipart/form-data').submit();
}


function resetData(){
	$('form').reset();
}
-->
//attr('enctype','multipart/form-data');
$(function () {
	
	
	$('.btn-primary:contains("수정")').on('click',function(){
		self.location='updatePurchaseView?tranNo=${purchase.tranNo}'
	});
	
	
	$('.btn-default:contains("확인")').on('click',function(){
		$(self.location).attr("href","listPurchase");
	});
	
})
</script>
</head>

<body>
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">구매 정보조회</h3>
	       <h5 class="text-muted">상품 
	       
	       <strong class="text-danger">
	       
	       <c:if test="${addChecker}">
		       등록 결과
		   </c:if> 
		   
		   <c:if test="${updateChecker}">
		       수정 결과
		   </c:if>		       
	       
	       <c:if test="${param.menu eq 'search' }">
		       상세조회
		   </c:if>		       
	       
	       </strong>
	       
	       페이지 입니다.</h5>
	    </div>
		
		<c:if test = "${updateChecker || (param.menu eq 'search' && user.role eq 'admin')}">
			<div class="row">
		  		<div class="col-xs-4 col-md-2"><strong>상 품 번호</strong></div>
				<div class="col-xs-8 col-md-4">${product.prodNo}</div>
			</div>
			
			<hr/>
		</c:if>
				
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상 품 명</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.purchaseProd.prodName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>상품 이미지</strong></div>
			<div class="col-xs-8 col-md-4">
				<c:forEach var="imgfileName" items="${purchase.purchaseProd.fileNames}">
					<img src="../images/uploadFiles/${imgfileName }" width="200" height="200" />
				</c:forEach>
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매자 아이디</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.buyer.userId}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매 방법</strong></div>
			<div class="col-xs-8 col-md-4">
					<c:if test="${purchase.paymentOption eq '1' }">
						현금구매
					</c:if>
					<c:if test="${purchase.paymentOption eq '2' }">
						신용구매
					</c:if>
				
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>구매 수량</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.quantity}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>구매자 이름</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.receiverName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>구매자 연락처</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.receiverPhone}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>구매자 주소</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.divyAddr}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>구매 요청사항</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.divyRequest}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>배송희망일</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.divyDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>주문일</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.orderDate}</div>
		</div>
		
		<hr/>
		
		
		
		<div class="row">
	  		<div class="col-md-12 text-center ">
		  		<c:if test="${purchase.tranCode eq '1' }">
		  			<button type="button" class="btn btn-primary">수정</button>
		  		</c:if>
	  		
	  			<button type="button" class="btn btn-default">확인</button>
	  		</div>
		</div>
		
		<br/>
		
 	</div>
 	<!--  화면구성 div Start /////////////////////////////////////-->
</body>
</html>