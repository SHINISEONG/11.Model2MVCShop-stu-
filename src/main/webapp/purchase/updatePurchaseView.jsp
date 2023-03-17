<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>구매정보수정</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script type="text/javascript" src="../javascript/calendar.js"></script>
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
	 body > div.container{
        	border: 3px solid #D6CDB7;
            margin-top: 60px;
        }
        
 
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">

function fncAddPurchase(prodNo) {
	document.getElementById("prodNo").value = prodNo
	document.addPurchase.submit();
}

function resetData(){
	document.detailForm.reset();
}


$(function () {
	$("button.btn.btn-primary:contains('수 정')").on("click" , function() {
		$('form').attr('method','post').attr('action','updatePurchase?tranNo=${purchase.tranNo}').submit();
	});
	
	$("button.btn.btn-primary:contains('뒤 로')").on('click',function(){
		history.go(-1);
	})
	
	//../product/addProductView.jsp
})

</script>
</head>

<body>

<jsp:include page="/layout/toolbar.jsp" />


<div class="container">
	
		<h1 class="bg-primary text-center">구 매 정 보 수 정</h1>
		
		<!-- form Start /////////////////////////////////////-->
		<form name="detailForm" class="form-horizontal">
		  
		  <input type="hidden" name="originalPurchaseQuantity" value="${purchase.quantity }"/>
		  <input type="hidden" name="prodNo" value="${product.prodNo }"/>
		  <input type="hidden" name="buyerId" value="${purchase.buyer.userId}"/>
		  
		  
		  
		  <div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">구매자 아이디</label>
		     <div class="col-sm-4">
				${user.userId}			   
		     </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">구매수량</label>
		     <div class="col-sm-4">
		     		${purchase.quantity }
		     		<input type = "hidden" name="quantity" value = ${purchase.quantity }/>
		     </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
		     <div class="col-sm-4">
		       <select 	name="paymentOption" class="form-control" id="paymentOption" >
				<option value="1" selected="selected">현금구매</option>
				<option value="2">신용구매</option>
			   </select>
		     </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">구매자이름</label>
		     <div class="col-sm-4">
		       <input type="text" class="form-control" id="receiverName" name="receiverName" placeholder="구매자이름" value = "${purchase.receiverName}"/>
		     </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">구매자연락처</label>
		     <div class="col-sm-4">
		       <input type="text" class="form-control" id="receiverPhone" name="receiverPhone" placeholder="구매자연락처" value="${purchase.receiverPhone}"/>
		     </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">구매자주소</label>
		     <div class="col-sm-4">
		       <input type="text" class="form-control" id="divyAddr" name="divyAddr" placeholder="구매자주소" value = "${purchase.divyAddr}"/>
		     </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
		     <div class="col-sm-4">
		       <input type="text" class="form-control" id="divyRequest" name="divyRequest" placeholder="구매요청사항" value ="${purchase.divyRequest}"/>
		     </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="manuDate" class="col-sm-offset-2 col-sm-2 control-label">배송희망일자</label>
		    <div class="col-sm-4">
		      <input type="date" name="divyDate"  class="form-control"  id = "divyDate" value = "${purchase.divyDate}"/>
		      </div>
		  </div>
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >수 정</button>
			  <button type="button" class="btn btn-default"  >뒤 로</button>
		    </div>
		  </div>
		
		</form>
		<!-- form Start /////////////////////////////////////-->
		
 	</div>
	<!--  화면구성 div end /////////////////////////////////////-->

</body>
</html>