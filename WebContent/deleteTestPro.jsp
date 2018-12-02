<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import="java.sql.*" %>

<% request.setCharacterEncoding("euc-kr"); %>

<%
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
		
	try{
		String jdbcUrl = "jdbc:mysql://localhost:3306/termp?useUnicode=true&characterEncoding=UTF-8";
		String dbId = "root";
		String dbPass = "admin";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		String sql = "select id, passwd from customer where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,id);
		rs = pstmt.executeQuery();
		
		// ���ڵ��� �˻� ����� �۾� ó��
		if(rs.next()){ //������ ���̵� �����ϴ� ��� ����
			String rId = rs.getString("id");
			String rPasswd = rs.getString("passwd");
			if(id.equals(rId) && passwd.equals(rPasswd)){// �н����尡 ��ġ�ϴ� ��� ����
				sql = "delete from customer where id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.executeUpdate();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html14/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>���ڵ� ����</title>
</head>
<body>
	member ���̺��� ���ڵ带 �����߽��ϴ�.
</body>
</html>
<%
			}else{// �н����尡 ��ġ���� ���� ���
				out.println("�н����尡 Ʋ�Ƚ��ϴ�.");
			}
		}else{//�������� �ʴ� ���̵��� ���
			out.println("���̵� Ʋ�Ƚ��ϴ�.");
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(rs != null) try{rs.close();}catch(SQLException sqle){}
		if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
		if(conn != null) try{conn.close();}catch(SQLException sqle){}
	}
%>