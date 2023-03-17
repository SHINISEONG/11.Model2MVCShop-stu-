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
	
	$('#addCart').on('click',function(){
		$('form').attr('action','../purchase/addCart').attr('method','post').submit();
	});
	
	$('.ct_btn01:contains("수정")').on('click',function(){
		fncUpdateProduct();
	});
	
	$('.btn-primary:contains("구매")').on('click',function(){
		$('form').attr('action','../purchase/addPurchase').attr('method','get').submit();
		
	});
	
	$('.btn-primary:contains("추가 등록")').on('click',function(){
		self.location='addProductView.jsp'
	});
	
	 
	$('.btn-default:contains("확인")').on('click',function(){
		$(self.location).attr("href","../product/listProduct?menu=${menu}");
	});
	
	$('.ct_btn01:contains("취소")').on('click',function(){
		$('form').attr('action','listProduct?menu=manage').attr('method','post').submit();
	});
	
	$('.ct_btn01:contains("이전")').on('click',function(){
		history.go(-1)
	});
})
</script>
</head>

<body>
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<form>
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">상품 정보조회</h3>
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
		
		<div>
			<input type="hidden" name="prodNo" value="${product.prodNo }"/>
		</div>
				
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상 품 명</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>상품 이미지</strong></div>
			<div class="col-xs-8 col-md-4">
				<c:forEach var="imgfileName" items="${product.fileNames}">
					<img src="../images/uploadFiles/${imgfileName }" width="200" height="200" />
				</c:forEach>
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>상품상세정보</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodDetail}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>제조일자</strong></div>
			<div class="col-xs-8 col-md-4">${product.manuDate}	</div>
		</div>
		
		<hr/>
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>가 격</strong></div>
			<div class="col-xs-8 col-md-4">${product.price}</div>
		</div>
		
		<hr/>
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>수 량</strong></div>
			
				<c:if test="${product.stock > 0 }">
					<div class="col-xs-8 col-md-4">${product.stock}</div>
				</c:if>
				
				<c:if test="${product.stock <= 0}">
			 		<div class="col-xs-8 col-md-4">품&nbsp;&nbsp;절</div>
				</c:if>
				
		</div>
		
		<hr/>
		<c:if test = "${user.role eq 'admin' && !(addChecker)}">
			<div class="row">
		  		<div class="col-xs-4 col-md-2 "><strong>등록일자</strong></div>
				<div class="col-xs-8 col-md-4">${product.regDate}</div>
			</div>
			<hr/>
		</c:if>
		
		
		
		<div class="row">
	  		<div class="col-md-12 text-center ">
		  		<c:if test="${addChecker}">
		  			<button type="button" class="btn btn-primary">추가 등록</button>
		  		</c:if>
		  		
		  		<c:if test = "${user.role eq 'user'}">
		  			<span class="col-md-2">
			  			
			  			<c:if test="${product.stock > 0}">
			  				<select name="quantity" class="form-control">
									<c:forEach var="i" begin = "1" end = "${product.stock }" >
										<option value="${i }" >${i }개</option>
									</c:forEach>
								</select>
							</c:if>
							
						</span>
					<c:if test="${product.stock > 0}">
					<button type="button" class="btn btn-default col-md-2" id="addCart">
					장바구니에 담기
					</button>
					</c:if>
					<input type="hidden" name="prodNo" value="${product.prodNo }"/>	

					<c:if test="${product.stock > 0}">
		  			<button type="button" class="btn btn-primary">구매</button>
		  		</c:if>

		  		</c:if>
	  			<button type="button" class="btn btn-default">확인</button>
	  		</div>
		</div>
		
		<br/>
		
 	</div>
 	</form>
 	<!--  화면구성 div Start /////////////////////////////////////-->
</body>
</html>