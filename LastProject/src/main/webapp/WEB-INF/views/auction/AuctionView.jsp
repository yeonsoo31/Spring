<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

	<title>E-SHOP HTML Template</title>

	<!-- Google font -->
	<link href="https://fonts.googleapis.com/css?family=Hind:400,700" rel="stylesheet">

	<!-- Bootstrap -->
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" id="testcss" />

	<!-- Slick -->
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/slick.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/slick-theme.css" />

	<!-- nouislider -->
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/nouislider.min.css" />

	<!-- Font Awesome Icon -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font-awesome.min.css">

	<!-- Custom stlylesheet -->
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
	
	<!-- popup -->
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layer-pop.css" />

	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
		  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
		  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->
		<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
        		crossorigin="anonymous"></script>
	<script>
		$(document).ready(function(){
			$(document).on('click','#biddingBtn',function(){
				var am_price = parseInt($("#am_price").val());
				var id = '<%=(String)session.getAttribute("loginId")%>';
				var a_number = "${auctionView.a_number}";
				var a_price = parseInt("${auctionView.a_price}");
				var page="${page}";
				console.log(am_price);
				console.log(id);
				console.log(a_number);
				if(id == "null"){
					alert("로그인이 필요한 서비스입니다.");
				}else if (am_price <= a_price){
					alert("현재 입찰가보다 가격이 낮거나 같습니다.");
				}else{
					$.ajax({
						type : "post",
						url : "bidding",
						data : {"id":id,
								"am_price":am_price,
								"a_number":a_number},
						dataType : "Json",
						success : function(result){
							console.log("접속됨");
							location.href="auctionView?a_number="+result.a_number+"&page="+page;
							/*$.getScript('${pageContext.request.contextPath}/resources/js/jquery.min.js');
							$.getScript('${pageContext.request.contextPath}/resources/js/bootstrap.min.js');
							$.getScript('${pageContext.request.contextPath}/resources/js/slick.min.js');
							$.getScript('${pageContext.request.contextPath}/resources/js/nouislider.min.js');
							$.getScript('${pageContext.request.contextPath}/resources/js/jquery.zoom.min.js');
							$.getScript('${pageContext.request.contextPath}/resources/js/main.js');
							
							var output = "<div class='section' id='price'>";
							output += "<div class='container'>";
							output += "<div class='row'>";
							output += "<div class='product product-details clearfix'>";
							output += "<div class='col-md-6'>";
							output += "<div id='product-main-view'>";
							output += "<div id='product-view'>";
							output += "<img src='${pageContext.request.contextPath}/resources/fileUpload/"+result.a_photo+"' alt=''";
							output += "</div>";
							output += "<div id='product-view'>";
							output += "<img src='${pageContext.request.contextPath}/resources/fileUpload/"+result.a_photo1+"' alt=''";
							output += "</div>";
							output += "<div id='product-view'>";
							output += "<img src='${pageContext.request.contextPath}/resources/fileUpload/"+result.a_photo2+"' alt=''";
							output += "</div>";
							output += "</div>";
							output += "<div id='product-view'>";
							output += "<div id='product-view'>";
							output += "<img src='${pageContext.request.contextPath}/resources/fileUpload/"+result.a_photo+"' alt=''";
							output += "</div>";
							output += "<div id='product-view'>";
							output += "<img src='${pageContext.request.contextPath}/resources/fileUpload/"+result.a_photo1+"' alt=''";
							output += "</div>";
							output += "<div id='product-view'>";
							output += "<img src='${pageContext.request.contextPath}/resources/fileUpload/"+result.a_photo2+"' alt=''";
							output += "</div>";
							output += "</div>";
							output += "</div>";
							output += "<div class='col-md-6'>";
							output += "<div class='product-body'>";
							output += "<div class='product-label'>";
							output += "<span>new</span>";
							output += "</div>";
							output += "<h2 class='product-name'>"+result.a_name+"</h2>";
							output += "<h3 class='product-price'>현재 입찰가 : "+result.a_price+" 원</h3>";
							output += "<h3>마감시간 : "+result.a_date+"</h3>";
							output += "<h4>상세설명"+result.a_information+"</h4>";
							output += "<br><br><br><br>";
							output += "<span class='text-uppercase'>입찰가격 : </span>";
							output += "<input type='text' id='am_price'>";
							output += "<button id='biddingBtn'>입찰하기</button>";
							output += "</div>";
							output += "</div>";
							output += "</div>";
							output += "</div>";
							output += "</div>";
							output += "</div>";
							$("#price").html(output).trigger("create");*/
							
						},
						error : function(){
							console.log("통신오류");
						}
					});
				}
			});
		});
	</script>
	
	<script>
	function timer(index){
		var a_date = document.getElementById("a_date").value;
		var d_day = new Date(a_date);
		var today = new Date();
		days = (d_day - today) / 1000 / 60 / 60 / 24;
		daysRound = Math.floor(days);
		hours = (d_day - today) / 1000 / 60 / 60 - (24 * daysRound);
		hoursRound = Math.floor(hours);
		minutes = (d_day - today) / 1000 /60 - (24 * 60 * daysRound) - (60 * hoursRound);
		minutesRound = Math.floor(minutes);
		seconds = (d_day - today) / 1000 - (24 * 60 * 60 * daysRound) - (60 * 60 * hoursRound) -
		(60 * minutesRound);
		secondsRound = Math.round(seconds);
		sec = " 초"
		min = " 분 "
		hr = " 시간 "
		dy = " 일 "
		document.getElementById("time").value = daysRound + 
		dy + hoursRound + hr + minutesRound + min + secondsRound + sec;
		window.setTimeout(function(){
			timer(index);
		},1000);
	};	
	
	
	function popup_open(){
		var a_number = '${auctionView.a_number}';
		var left = (document.body.offsetWidth / 2) - (700 / 2);
		var top = (window.screen.height / 2) - (400 / 2);
		var settings ='scrollbars=0,toolbar=0,menubar=no,location=no,height=400,width=700,left='+left+',top='+top;
		var win = window.open("biddingList?a_number="+a_number+"&paging="+${page},"입찰자목록",settings);
		win.focus();
	}
	
	function buy(){
		var a_number = '${auctionView.a_number}';
		var id = '${sessionScope.loginId}';
		location.href="auctionOrder?a_number="+a_number+"&id="+id;
	}
	
	function wrapWindowByMask(){
		var maskHeight = $(document).height();
		var maskWidth = $(window).width();
		
		$('#mask').css({
			'width':maskWidth,
			'height':maskHeight
		});
		
		$('#mask').fadeTo('slow',0.5);
	}
	
	function popupOpen(){
		$('.layerpop').css("position","absolute");
		$('.layerpop').css("top",(($(window).height() - $('.layerpop').outerHeight())/2) + $(window).scrollTop());
		$('.layerpop').css("left",(($(window).width() - $('.layerpop').outerWidth())/2) + $(window).scrollLeft());
		$('.layerpop').draggable();
		$('#layerbox').show();
	}
	
	function popupClose(){
		$('#layerbox').hide();
		$('#mask').hide();
	}
	
	function qnaWrite(){
		var id='${sessionScope.loginId}';
		if(id==''){
			alert("로그인이 필요한 서비스입니다.");
		}else{
		popupOpen();
		wrapWindowByMask();
		}
	}
	
	function moreList(){
		var a_number = "${auctionView.a_number}";
		var paging = 2;
		$.ajax({
			type : "post",
			url : "moreList",
			data : {"a_number":a_number,
					"addpage":paging},
			dataType : "json",
			success : function(result){
				console.log(result);
				console.log(result[0][0]);
				var output='<div>';
				for(var i in result[0]){
					output += '<div class="col-md-1">질문</div>';
					output += '<div class="col-md-11">';
					output += '<div class="product-reviews">';
					output += '<div class="single-review">';
					output += '<div class="review-heading">';
					output += '<div><a href="#"><i class="fa fa-user-o"></i>'+result[0][i].id+'</a></div>';
					output += '<div><a href="#"><i class="fa fa-clock-o"></i>'+result[0][i].q_date+'</a></div>';
					output += '</div>';
					output += '<div class="review-body">';
					output += '<p>'+result[0][i].q_contents+'</p>';
					output += '</div>';
					output += '</div>';
					output += '</div>';
					output += '</div>';
					output += '<div class="col-md-12 line">';
					output += '</div>';
					for(var j in result[1]){
						if(result[0][i].q_number == result[1][j].q_number){
							output +='<div class="col-md-12 answer">';
							output +='<div class="col-md-1">';
							output +='<img width="20" height="20" src="${pageContext.request.contextPath}/resources/img/화살표.PNG">';
							output +='<em>답변</em></div>';
							output +='<div class="col-md-11">';
							output +='<div class="product-reviews">';
							output +='<div class="single-review">';
							output +='<div class="review-heading">';
							output +='<div><a href="#"><i class="fa fa-user-o"></i>'+result[1][j].id+'</a></div>';
							output +='<div><a href="#"><i class="fa fa-clock-o"></i>'+result[1][j].qa_date+'</a></div>';
							output +='</div>';
							output +='<div class="review-body">';
							output +='<p>'+result[1][j].qa_contents+'</p>';
							output +='</div>';
							output +='</div>';
							output +='</div>';
							output +='</div>';
							output +='</div>';
						}
					}
				}
				output+= '</div>';
				$('#moreListBtn').hide();
				$('#addList').html(output);
			},
			error : function(){
				console.log("통신오류");
			}
		});
	}
	
	function auctionQnA(){
		var id='${sessionScope.loginId}';
		var a_number='${auctionView.a_number}';
		var s_id='${auctionView.id}';
		var q_contents=document.getElementById("contents").value;
		console.log(id);
		console.log(a_number);
		console.log(s_id);
		console.log(q_contents);
		$.ajax({
			type:"post",
			url:"auctionQnA",
			data:{"id":id,
				  "a_number":a_number,
				  "s_id":s_id,
				  "q_contents":q_contents},
			dataType:"text",
			success:function(result){
				if(result=="OK"){
					alert("등록되었습니다");
					popupClose();
					var output
				}else{
					alert("오류");
				}
			},
			error:function(){
				console.log("통신오류");
			}
		});
		
	}
	</script>

</head>

<body>
	<div>
		<jsp:include page="/WEB-INF/views/top.jsp"></jsp:include>
	</div>
	<div style="text-align:center">
	</div>
	<!-- section -->
	<div class="section" id="price">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div class="row">
				<!--  Product Details -->
				<div class="product product-details clearfix">
				<c:choose>
					<c:when test="${auctionView.a_photo2 ne null && auctionView.a_photo1 ne null}">
					<div class="col-md-6">
						<div id="product-main-view">
							<div class="product-view">
								<img src="${pageContext.request.contextPath}/resources/fileupload/${auctionView.a_photo}" alt="">
							</div>
							<div class="product-view">
								<img src="${pageContext.request.contextPath}/resources/fileupload/${auctionView.a_photo1}" alt="">
							</div>
							<div class="product-view">
								<img src="${pageContext.request.contextPath}/resources/fileupload/${auctionView.a_photo2}" alt="">
							</div>
						</div>
						<div id="product-view">
							<div class="product-view">
								<img src="${pageContext.request.contextPath}/resources/fileupload/${auctionView.a_photo}" alt="">
							</div>
							<div class="product-view">
								<img src="${pageContext.request.contextPath}/resources/fileupload/${auctionView.a_photo1}" alt="">
							</div>
							<div class="product-view">
								<img src="${pageContext.request.contextPath}/resources/fileupload/${auctionView.a_photo2}" alt="">
							</div>
						</div>
					</div>
					</c:when>
					<c:when test="${auctionView.a_photo1 ne null && auctionView.a_photo2 eq null}">
					<div class="col-md-6">
						<div id="product-main-view">
							<div class="product-view">
								<img src="${pageContext.request.contextPath}/resources/fileupload/${auctionView.a_photo}" alt="">
							</div>
							<div class="product-view">
								<img src="${pageContext.request.contextPath}/resources/fileupload/${auctionView.a_photo1}" alt="">
							</div>
						</div>
						<div id="product-view">
							<div class="product-view">
								<img src="${pageContext.request.contextPath}/resources/fileupload/${auctionView.a_photo}" alt="">
							</div>
							<div class="product-view">
								<img src="${pageContext.request.contextPath}/resources/fileupload/${auctionView.a_photo1}" alt="">
							</div>
						</div>
					</div>
					</c:when>
					<c:otherwise>
					<div class="col-md-6">
						<div id="product-main-view">
							<div class="product-view">
								<img src="${pageContext.request.contextPath}/resources/fileupload/${auctionView.a_photo}" alt="">
							</div>
						</div>
						<div id="product-view">
							<div class="product-view">
								<img src="${pageContext.request.contextPath}/resources/fileupload/${auctionView.a_photo}" alt="">
							</div>
						</div>
					</div>
					</c:otherwise>
				</c:choose>
					<div class="col-md-6">
						<div class="product-body">
							<div class="product-label">
								<span>New</span>
							</div>
							<h2 class="product-name">${auctionView.a_name}</h2>
							<h3 class="product-price">현재 입찰가 : ${auctionView.a_price} 원</h3>
							<input type="hidden" id="a_date" value="${auctionView.a_date}">
							<input type="hidden" onclick="timer()">
							<h3>마감 시간 : <input type="text" id="time" style="border:0px;"readonly ></h3>
							<script>
								$(document).ready(timer());
							</script>
							<h4>상세 설명 </h4>
							<br><br><br><br>
				
								<span class="text-uppercase">입찰가격 : </span>
								<input type="text" id="am_price">						
								<button id="biddingBtn"> 입찰하기</button>
								<button onclick="buy()">구매하기</button>
								<button onclick="location.href='auctionModifyForm?a_number=${auctionView.a_number}'">수정</button>
								<button onclick="location.href='auctionDelete?a_number=${auctionView.a_number}'">삭제</button>
								<button onclick="popup_open()">입찰자목록</button>
									
				
						</div>
					</div>
				</div>
				<!-- /Product Details -->
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>
	<!-- /section -->
	<div class="container">
	<div class="col-md-12">
		<div class="product-tab">
			<ul class="tab-nav">
				<li class="active"><a data-toggle="tab" href="#tab1">상품 상세 설명</a></li>
				<li><a data-toggle="tab" href="#tab2">상품 문의</a></li>
			</ul>
			<div class="tab-content">
			<div id="tab1" class="tab-pane fade in active">
					${auctionView.a_information}
			</div>
			
			<div id="tab2" class="tab-pane fade in">

			<div class="row">
				<div class="col-md-12">
					<div class="col-md-8">
					<h4 class="text-uppercase">상품문의</h4>
					<p>구매한 상품의 취소/반품은 구매내역에서 신청 가능합니다.</p>
					<p>상품문의 및 후기게시판을 통해 취소나 환불, 반품 등은 처리되지 않습니다.</p>
					<p>가격, 판매자, 교환/환불 및 배송 등 해당 상품 자체와 관련 없는 문의는 고객센터 내 1:1 문의하기를 이용해주세요.</p>
					<p>"해당 상품 자체"와 관계없는 글, 양도, 광고성, 욕설, 비방, 도배 등의 글은 예고 없이 이동, 노출제한, 삭제 등의 조치가 취해질 수 있습니다.</p>
					<p>공개 게시판이므로 전화번호, 메일 주소 등 고객님의 소중한 개인정보는 절대 남기지 말아주세요.</p>
					</div>
						<div class="col-md-offset-11">
						<button onclick="qnaWrite()">문의하기</button>
						</div>
					</div>
			<div class="section-title">
			　
			</div>
				<div class="col-md-12" id="qnaWrite">
				<c:forEach var="auctionQnA" items="${auctionQnA}" varStatus="status">
					<div class="col-md-1">질문</div>
					<div class="col-md-11">
					<div class="product-reviews">
						<div class="single-review">
							<div class="review-heading">
								<div><a href="#"><i class="fa fa-user-o"></i>${auctionQnA.id} </a></div>
								<div><i class="fa fa-clock-o"></i> ${auctionQnA.q_date}</div>
							</div>
							<div class="review-body">
								<p>${auctionQnA.q_contents}</p>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-12 line">
				
				</div>
				<c:forEach var="answer" items="${answer}">
				<c:if test="${auctionQnA.q_number eq answer.q_number }">
					<div class="col-md-12 answer">
						<div class="col-md-1">
							<img width="20" height="20" src="${pageContext.request.contextPath}/resources/img/화살표.PNG">
							<em>답변</em></div>
						<div class="col-md-11">
							<div class="product-reviews">
								<div class="single-review">
									<div class="review-heading">
										<div><a href="#"><i class="fa fa-user-o"></i>${answer.id} </a></div>
										<div><a href="#"><i class="fa fa-clock-o"></i>${answer.qa_date }</a></div>
									</div>
									<div class="review-body">
										<p>${answer.qa_contents }</p>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-12 line">
					
					</div>
				</c:if>
				</c:forEach>
				</c:forEach>
				<div style="text-align:center;"class="col-md-12">
				<c:if test="${fn:length(auctionQnA) > 5}">
				<button id="moreListBtn"style="width:800px;" onclick="moreList()">더보기</button>
				</c:if>
				</div>
				<div id="addList">
				
				</div>
			</div>
	
	</div>
	</div>
	</div>
	<button onclick="location.href='auctionList?page=${page}'">목록</button>
</div>
</div>
</div>

<!-- 팝업뜰때 배경 -->
<div id="mask"></div>
<!-- 레이어 팝업 Open -->
<div id="layerbox" class="layerpop" style="width:700px; height:400px;">
	<article class="layerpop_area">
		<div class="title">상품 문의</div>
		<a href="javascript:popupClose();" class="layerpop_close" id="layerbox_close">
		<img style="width:25px; height:25px; display:block; position:absolute;" src="${pageContext.request.contextPath}/resources/img/close-button_icon-icons.com_72803.png">
		</a><br>
		<div class="content">
			<table>
				<tr>
					<th>문의상품</th>
					<td><input type="text" value="${auctionView.a_name}" name="a_name" size="20" style="width:100%; border:0"></td>
				</tr>
				<tr>
					<th>문의내용</th>
					<td><textarea id="contents" style="resize: none; width:100%; border:0" rows="8" cols="50"></textarea>
				</tr>
			</table>
		<div style="text-align:right;">
			<button onclick="auctionQnA()">문의하기</button>
		</div>
		</div>
	</article>
</div>
<!-- 팝업 End -->

	<div>
		<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	</div>
					

	<!-- jQuery Plugins -->
	<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/slick.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/nouislider.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery.zoom.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js"></script>

</body>

</html>
