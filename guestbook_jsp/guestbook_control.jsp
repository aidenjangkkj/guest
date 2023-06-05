<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" errorPage="guestbook_error.jsp" import="guestbook.*"%>
<%  request.setCharacterEncoding("euc-kr"); %>
 
<jsp:useBean id="gb" scope="page" class="guestbook.GuestBean"/>
<jsp:useBean id="guestbook" class="guestbook.GuestBook"/>
<jsp:setProperty property="*" name="gb"/>
<jsp:setProperty property="*" name="guestbook"/>
 
<%
    String action = request.getParameter("action");
    if(action.equals("list")) {
        response.sendRedirect("guestbook_list.jsp");
    }
    else if(action.equals("insert")) {
        if(gb.insertDB(guestbook)) {
            response.sendRedirect("guestbook_list.jsp");
        }
        else
            throw new Exception("DB insert error");
    }
    else if(action.equals("edit")) {
        //GuestBook gbook = gb.getDB(guestbook.getGb_id());
        GuestBook gbook = gb.getDB(Integer.parseInt(request.getParameter("gb_id")));
            request.setAttribute("gbook", gbook);
            pageContext.forward("guestbook_edit_form.jsp");
        }
    else if(action.equals("update")) {
        if(gb.updateDB(guestbook)) {
            response.sendRedirect("guestbook_list.jsp");
        }
        else
            throw new Exception("DB update error");
    }
    else if(action.equals("delete")) {
        if(gb.deleteDB(guestbook.getGb_id())) {
            response.sendRedirect("guestbook_list.jsp");
        }
        else
            throw new Exception("DB delete error");
    }
    else {
        out.println("<script>alert('action parameter confirm!!!')"
            + "</script>");
    }
%>