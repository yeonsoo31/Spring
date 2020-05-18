<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%> 
<% response.setContentType("text/html; charset=UTF-8");%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/summernote-lite.css">	

</head>
<body>

 <div class="col-md-10" style="margin-left:80px;">
 	<textarea id="summernote" rows="5" name="explanation" style="width:100%; height:250px;"></textarea>
 </div>
       
<script src="${pageContext.request.contextPath}/resources/js/summernote-lite.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/summernote-ko-KR.js"></script>
 <script>
 $('#summernote').summernote({
		height: 300,
		width : 1000,
		minHeight: null,
		maxHeight: null,
		focus: true,
		lang: "ko-KR",
		callbacks: {
			onImageUpload : function(files){
				sendFile(files[0],this);
			}
		}
			
	});
		
	function sendFile(file, editor){
		var data = new FormData();
		data.append("file", file);
		console.log(file);
		$.ajax({
			data : data,
			type : "POST",
			url : "SummerNoteImageFile",
			contentType : false,
			processData : false,
			success : function(data){
				console.log(data);
				console.log(editor);
				$(editor).summernote("insertImage",data.url);
			}
		});
	}

</script>
</body>

</html>

