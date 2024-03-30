

<%@page import="entity.visitor"%>
<%@page import="entity.student"%>
<%@page import="entity.collegeadmin"%>
<%@page import="helper.message"%>
<%@page import="entity.course"%>
<%@page import="java.util.*"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.collegedao"%>

    <div class="row">
        <%
          int cid= Integer.parseInt(request.getParameter("cid"));
          collegedao cd = new collegedao(ConnectionProvider.getConnection());
          Vector<course> vd = cd.getcourse(cid);
          Iterator<course> it = vd.iterator();
          while(it.hasNext())
          {
           
            course cr = it.next();
            
        %>
    
                        <div class="col-xl-3 col-md-6 mb-2">
                            <div class="card shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs text-primary text-uppercase mb-1">
                                                <%= cr.getC_name() %></div>
                                            <div class="h5 mb-1 font-weight-bold text-gray-800">Since : <%= cr.getC_since() %></div>
                                            <p class=" text-gray-800">Duration : <%= cr.getC_duration() %></p>
                                        </div>
                                        <div class="col-auto">
                                            <i class="bi bi-chat-dots h1 text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
       
        <% } %>
 </div>