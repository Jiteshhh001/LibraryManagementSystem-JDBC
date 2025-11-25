<%@ include file="db.jsp" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width,initial-scale=1"/>
  <title>LibZone — Home</title>
</head>
<body>
<main class="container">
  <section class="hero">
    <div class="hero-left">
      <h2>Manage library operations.</h2>
      <p class="lead">Keep track of books, members, issues and returns.</p>
      <div class="hero-actions">
        <a class="btn-primary" href="books.jsp">Manage Books</a>
        <a class="btn-ghost" href="members.jsp">Manage Members</a>
      </div>
      <div class="stats">
        <div class="stat">
          <div class="stat-value">
            <%
              try {
                PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) AS cnt FROM books");
                ResultSet rs = ps.executeQuery();
                if(rs.next()) out.print(rs.getInt("cnt"));
              } catch(Exception e){ out.print("—"); }
            %>
          </div>
          <div class="stat-label">Books</div>
        </div>

        <div class="stat">
          <div class="stat-value">
            <%
              try {
                PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) AS cnt FROM members");
                ResultSet rs = ps.executeQuery();
                if(rs.next()) out.print(rs.getInt("cnt"));
              } catch(Exception e){ out.print("—"); }
            %>
          </div>
          <div class="stat-label">Members</div>
        </div>

        <div class="stat">
          <div class="stat-value">
            <%
              try {
                PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) AS cnt FROM issues WHERE returned=0");
                ResultSet rs = ps.executeQuery();
                if(rs.next()) out.print(rs.getInt("cnt"));
              } catch(Exception e){ out.print("—"); }
            %>
          </div>
          <div class="stat-label">Issued</div>
        </div>
      </div>
    </div>

    <div class="hero-right">
      <div class="card-illustration">
        <div class="dash-card">
          <div class="dash-header">Quick Actions</div>
          <div class="dash-body">
            <div class="mini">
              <div class="mini-title">Overdue</div>
              <div class="mini-value">
                <%
                  try {
                    PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) AS cnt FROM issues WHERE returned=0 AND due_date < CURDATE()");
                    ResultSet rs = ps.executeQuery();
                    if(rs.next()) out.print(rs.getInt("cnt"));
                  } catch(Exception e){ out.print("0"); }
                %>
              </div>
            </div>
            <div class="mini">
              <div class="mini-title">Available</div>
              <div class="mini-value">
                <%
                  try {
                    PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) AS cnt FROM books WHERE total_copies > issued_copies");
                    ResultSet rs = ps.executeQuery();
                    if(rs.next()) out.print(rs.getInt("cnt"));
                  } catch(Exception e){ out.print("><"); }
                %>
              </div>
            </div>
            <div class="mini">
              <div class="mini-title">Pending</div>
              <div class="mini-value">-</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
<br>
<br>
<br>
  <section class="container features">
    <h3>Features</h3>
    <div class="feature-grid">
      <div class="feature"><div class="icon"></div><h4>Catalog Management</h4><p>Add books, update copies, search fast.</p></div>
      <div class="feature"><div class="icon"></div><h4>Member Management</h4><p>Register members, track borrow history.</p></div>
      <div class="feature"><div class="icon"></div><h4>Issue & Return</h4><p>Issue books with due dates and record returns.</p></div>
    </div>
  </section>
</main>

<footer class="footer">
  <div class="container-row">
    <div><span id="year"></span> LibZone</div>

  </div>
</footer>

<script>document.getElementById('year').textContent = new Date().getFullYear();</script>
</body>
</html>
