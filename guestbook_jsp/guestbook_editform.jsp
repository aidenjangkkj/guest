<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR" import="guestbook.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>방명록: 수정화면</title>
<script type="text/javascript">
    function delcheck() {
        result = confirm("삭제 하시겠습니까?");
        if(result) {
            document.form1.action.value="delete";
            document.form1.submit();
        }
        else
            return;
    }
    function emptycheck() {
    	if(document.getElementById("gb_name").value==""){
    		alert("모든 칸을 입력하세요");
    	}
    	else if(document.getElementById("gb_email").value==""){
    		alert("모든 칸을 입력하세요");
    	}
    	else if(document.getElementById("gb_tel").value==""){
    		alert("모든 칸을 입력하세요");
    	}
    	else if(document.getElementById("gb_passwd").value==""){
    		alert("모든 칸을 입력하세요");
    	}
    	else if(document.getElementById("gb_contents").value==""){
    		alert("모든 칸을 입력하세요");
    	}
    }
</script>
</head>
<%
    GuestBook guestbook = (GuestBook)request.getAttribute("gbook");
%>
<body>
    <center>
        <h2>방명록: 수정화면</h2>
        <hr>
        [<a href=guestbook_control.jsp?action=list>게시물 목록으로</a>]
        <form name="form1" method="post"                                       action="guestbook_control.jsp">
        <input type="hidden" name="gb_id" value="                             <%=guestbook.getGb_id()%>">
        <input type="hidden" name="action" value="update">
            <table cellpadding="5" cellspacing="0" border="1">
                <tr>
                    <td bgcolor="#99ccff">작성자</td>
                    <td align="left">
                        <input type="text" name="gb_name" size="20"                           value="<%=guestbook.getGb_name()%>">
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#99ccff">email</td>
                    <td align="left">
                        <input type="text" name="gb_email" size="20"                           value="<%=guestbook.getGb_email()%>">
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#99ccff">전화번호</td>
                    <td align="left">
                        <input type="text" name="gb_tel" size="20"                             value="<%=guestbook.getGb_tel()%>">
                        </td>
                </tr>
                <tr>
                    <td bgcolor="#99ccff">비밀번호</td>
                    <td align="left">
                        <input type="password" name="gb_passwd"                           size="20" value="<%=guestbook.getGb_passwd()%>">
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="left">
                        <textarea rows="5" cols="40"                                           name="gb_contents" >                                                  <%=guestbook.getGb_contents()%></textarea>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" value="저장" onclick="emptycheck()">
                        <input type="reset" value="취소">
                        <input type="button" value="삭제" onclick="delcheck()">
                    </td>
                </tr>
            </table>
        </form>
    </center>
</body>
</html>