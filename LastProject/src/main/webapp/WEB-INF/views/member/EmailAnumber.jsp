<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table border="1" width="300" height="300" align= "center">

<h3 style="color: green; font-weight: bold; text-align:center;">입력한 이메일로 받은 인증번호를 입력하세요.<br>
												(인증번호가 맞아야 다음 단계로 넘어가실 수 있습니다.)</h3><br>
        <div style="text-align:center;">
            <tr>        
                <td>
                <center>
                    <form action="join_injeung.do${dice}" method="post"><!-- 받아온 인증코드를 컨트롤러로 넘겨서 일치하는지 확인 -->                  
                    <center>
                        <br>
                        <div>
                        <input type="hidden" name="id" value="${findEmail}">
                            인증번호 입력 : <input type="number" name="email_injeung"
                                placeholder="  인증번호를 입력하세요. ">
                        </div>                                        
                        <br> <br>
                        <button type="submit" name="submit">확인</button>
                        </div>
				</td>
			</tr>
                    </center>
            </table>
        </form>
</center>
</body>
</html>