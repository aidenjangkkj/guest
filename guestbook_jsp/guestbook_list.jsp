<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR" import="java.util.*" import="guestbook.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>방명록: 목록화면</title>
<script type="text/javascript">
    function check(gb_id) {
        pwd = prompt('비밀번호 입력', "password");
        if(pwd != null) {
            document.location.href="guestbook_control.jsp? action=edit&gb_id=" + gb_id+"&upasswd="+pwd;
        }
    }
</script>
</head>
<%
    GuestBean gb = new GuestBean();
    ArrayList<GuestBook> datas = gb.getDBList();
%>
<body>
<center>
    <h2>방명록: 목록화면</h2>
    <hr>
    <form>
        <a href="guestbook_form.jsp">방명록 쓰기</a><p>
        <table cellpadding="5" cellspacing="0" border="1">
            <tr bgcolor="#99ccff">
                <td align="center">번호</td>
                <td align="center">작성자</td>
                <td align="center">전화번호</td>
                <td align="center">작성일</td>
                <td align="center">내용</td>
            </tr>
            <%
                for(GuestBook guestbook : datas) {
            %>
                <tr>
                    <td><%=guestbook.getGb_id() %></td>
                    <td><%=guestbook.getGb_name() %></td>
                    <td><%=guestbook.getGb_tel() %></td>
                    <td><%=guestbook.getGb_date() %></td>
                    <td align="left"><a                                                href=javascript:check('<%=guestbook.getGb_id()%>')>
                    <%
                        String str = guestbook.getGb_contents();
                        String restr = "";
                        if(str.length() >= 15) {
                            restr = str.substring(0, 15);
                            out.print(restr + "...");
                        }
                        else
                            out.println(str);
                    %>
                    </a></td>
                </tr>
            <%
                }
            %>
        </table>   
    </form>
</center>
</body>
</html>