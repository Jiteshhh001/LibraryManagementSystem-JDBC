<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="css/style.css">
<header class="topbar">
  <div class="container-row">
    <div class="brand">
      <img src="images/logo.png" alt="logo" class="logo">
      <div class="brand-text">
        <h1>Lib<span>Zone</span></h1>
        <p class="tag">Campus Library Management</p>
      </div>
    </div>
    <nav class="nav">
      <a href="index.jsp" class="<%= request.getRequestURI().endsWith("index.jsp")?"active":"" %>">Home</a>
      <a href="books.jsp" class="<%= request.getRequestURI().endsWith("books.jsp")?"active":"" %>">Books</a>
      <a href="members.jsp" class="<%= request.getRequestURI().endsWith("members.jsp")?"active":"" %>">Members</a>
      <a href="issue.jsp" class="<%= request.getRequestURI().endsWith("issue.jsp")?"active":"" %>">Issue</a>
      <a href="return.jsp" class="<%= request.getRequestURI().endsWith("return.jsp")?"active":"" %>">Return</a>
      <a href="reports.jsp" class="<%= request.getRequestURI().endsWith("reports.jsp")?"active":"" %>">Reports</a>
    </nav>
    <button class="cta" onclick="location.href='books.jsp'">Add Book</button>
  </div>
</header>
