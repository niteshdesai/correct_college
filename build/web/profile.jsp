<%@page import="entity.com_reply"%>
<%@page import="dao.commentdao"%>
<%@page import="entity.comment"%>
<%@page import="entity.course"%>
<%@page import="entity.visitor"%>
<%@page import="java.util.Vector"%>
<%@page import="entity.teacher"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.mysql.cj.jdbc.IterateBlock"%>
<%@page import="dao.studentdao"%>
<%@page import="helper.RatingCount"%>
<%@page import="entity.college"%>
<%@page import="dao.collegedao"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="entity.student,java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <title>Document</title>
    <%@include file="./links.html" %>
    <style>
    
    .visitor-table tr
    {
      padding:2rem 0rem !important;
    }
                          .comment{
                margin: 5px;
                border: 1px solid rgba(0,0,0,.125);
                box-shadow: 0px 0px 13px -9px rgba(0, 0,0,0.75);
                -webkit-box-shadow: 0px 0px 13px -9px rgba(0, 0,0,0.75);
                -moz-box-shadow: 0px 0px 13px -9px rgba(0, 0,0,0.75);
            }
            .comment-contain
            {
                background-color: transparent;
                   box-shadow: 0px 0px 13px -9px rgba(0, 0,0,0.75);
            }
            .comment-contain img{
                width: 2rem;
                height:2rem;
                border-right:50% !important;

            }
            .comment-header{
                display: flex;
                gap:0.5rem;
                align-items: center;
            }
            .comment-header p{
                position: relative;
                top: 0.3rem;
            }
            .reply-contain{
                display: flex;
                gap:0.5rem;
                display: flex;
                gap:0.5rem;
                align-items: center;
            }
            .comment-header p{
                position: relative;
                top: 0.3rem;
            }
            .reply-contain{
                display: flex;
                gap:0.5rem;
            }
            .like-dilike-icon-contain{
                background-color:transparent;   
               
                padding: 0.3rem;
                border-radius:50%;
                color:black;
               box-shadow: 0px 5px 10px -7px black;
            }

     
            .course-name{
                border-bottom:2px solid #8490ff;
        
            }
  /*main comment box contain all comment*/
          .our-comments{
              background-color:red !important;
        
              overflow:scroll;
              
              position:relative;
          
            }
            /*//send comment box */
            .comment-box{
                position:sticky;
               background-color:whitesmoke;
               z-index:99;
               color:whitesmoke;
                bottom:0rem;
                border-radius: 0.5rem;
 
               
                z-index:9999 !important;

            }
    </style>
</head>
<body>
   
    <%@include file="./navbar.jsp" %>
    <% 
       student st = (student)session.getAttribute("loginstudent");
       vs = (visitor)session.getAttribute("visitorlogin");
       if(st!=null)
       {
        Connection con = ConnectionProvider.getConnection();
    %>
    <input type="hidden" class="cid" value="<%= st.getCid() %>"/>
    <input type="hidden" class="sid" value="<%= st.getSid() %>"/>
        <div class="container-fluid" style="background-color: rgb(249,249,255);">
            <div class="container pt-5 profile-section">
        
               
             
                <div class="row align-items-start mb-4">
                    <div class="col-12 col-sm-9 col-md-6 col-lg-3">
                        <div class="card card1">
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item text-center">
                                    <img src="./userimg/<%= st.getSimg() %>" alt="student" class="img-fluid profile-img"/>
                                
                                </li>
                                <li class="list-group-item">
                                  
                                    <table>
                                       <tr>
                                         <td><b>En_No</b> </td>
                                            <td>:</td>
                                            <td><%= st.getSen_no() %></td>
                                        </tr>
                                        <tr>
                                            <td><b>Roll No</b> </td>
                                            <td>:</td>
                                            <td><%= st.getSroll_no() %></td>
                                        </tr>
                                        <tr>
                                            <td><b>Sem </b></td>
                                            <td>:</td>
                                            <td><%= st.getSsem() %></td>
            
                                        </tr>
                                        <tr>
                                            <td><b>Section</b></td>
                                            <td>:</td>
                                            <td><%= st.getSsection() %></td>
            
                                        </tr>
                                        <tr>
                                            <td><b>Gender</b></td>
                                            <td>:</td>
                                            <td><%= st.getSgender() %></td>
            
                                        </tr>
                                        <tr>
                                            <td><b>Mo_No</b></td>
                                            <td>:</td>
                                            <td><%= st.getSmobile() %></td>
            
                                        </tr>
                                        <tr>
                                            <td><b>City</b></td>
                                            <td>:</td>
                                            <td><%= st.getScity() %></td>
            
                                        </tr>
                                   
                                    </table>
            
                
                                </li><!-- comment -->
                                <li class="list-group-item">        <a class="dropdown-item student-logout" style="cursor:pointer;color:#3640a0;font-weight:700;background-color: #f3f4fe;width: 5.5rem;border-radius: 1rem;box-shadow: 0px 3px 10px -5px black;font-weight: 500;opacity: 95%">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400 me-2"></i>
                                    Logout
                                                </a></li>
            
                            </ul>
                        </div>
                    </div>
                    <div class="col-md-7 col-lg-9">
                   
                    <% 
                      String qtr = "select * from coll_rating where sid=?";
                      PreparedStatement ps = con.prepareStatement(qtr);
                      ps.setInt(1,st.getSid());
                      ResultSet rs = ps.executeQuery();
                      if(rs.next())
                      {
                       collegedao cd = new collegedao(ConnectionProvider.getConnection());
                      college col = cd.findcollege(st.getCid());
                    %>
                    
        
                    
                        <div class="card mb-3 card1">
                            <div class="row g-0 align-items-center">
                                <div class="col-md-8">
                                    <div class="card-body">
                                        <h5 class="card-title"><%= col.getCname() %></h5>
                                        <p class="card-text mb-1 popular-college-detail"> 
                                         
                                      <%= col.getCdesc() %>
                                        </p>
        
                                        <p class="text-start mb-2"><b>Our Activity</b> : <%= col.getCactivity() %>
                                        </p>
                                         <p class="text-start mb-2"><b>Our Course</b> :  <% 
                                        course cou = col.getCoure();
                                        String qtr2 = "select c_name from course where cid=?";
                                        Connection con1 = ConnectionProvider.getConnection();
                                        PreparedStatement ps2 = con1.prepareStatement(qtr2);
                                        ps2.setInt(1,col.getCid());
                                        ResultSet rs2 = ps2.executeQuery();
                                        while(rs2.next())
                                        {
                                          out.println(rs2.getString(1));
                                        }
                                      %>
                                        </p>
                                        <div class="mb-2">
                                            <span class="rat-value" value="">
                                                <%
                                                     qtr =  "select sum(c_rval) from coll_rating where cid="+st.getCid()+" and sid="+st.getSid();
                             Statement st1 = con.createStatement();
                             rs = st1.executeQuery(qtr);
                             float star=0;
                            if(rs.next())
                            {
                            star = rs.getFloat(1);
           
                                      }
                         
                           String qtr1 = "select count(sid) from coll_rating where cid=? and sid=?";
                           PreparedStatement ps1 = con.prepareStatement(qtr1);
                         
                           ps1.setInt(1,st.getCid());
                           ps1.setInt(2,st.getSid());
                           ResultSet rs1 = ps1.executeQuery();
                           
                            float user=0;
                            if(rs1.next())
                            {
                     
                             user = rs1.getInt(1);
                           
                              }
                            out.print(RatingCount.rcount(star,user));
 
%> </span>   
                                                <span class="ms-2"><i class="bi bi-star-fill star-bg"></i><i
                                                    class="bi bi-star-fill star-bg"></i><i class="bi bi-star-fill star-bg"></i><i class="bi bi-star-fill star-bg"></i><i
                                                    class="bi bi-star-fill star-bg"></i></span>
                                            <span class="bi bi-star rat-star ms-4" data-bs-toggle="modal"
                                                  data-bs-target="#exampleModal">Rate</span>
                                        </div>
                                            <p class="popular-college-detail mb-2 fs-6"><i class="bi bi-person-fill-check"></i>
                           <%= user %>
                        </p>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <img src="./userimg/<%= col.getCimg() %>" class="img-fluid rounded-start img-fluid py-2 px-2" alt="...">
                                </div>
        
                            </div>
                        </div>
        
        
                    <%  } %>
                      
        
              
                    </div>
                </div>
            
                <div class="row">
                
                   <% 
                      studentdao sd = new studentdao(ConnectionProvider.getConnection());
                      Vector<teacher> tech = sd.getratedteacher(st.getSid());
                      Iterator<teacher> it= tech.iterator();
                      if(it.hasNext())
                      {
                      %>    <div class="row">
                    <div class="col-8 col-sm-5 col-md-3 col-lg-2 mb-4">
                        <h4>Our Teachers</h4>
                    </div>
                </div>
                   <%}
                      while(it.hasNext())
                              {
                                  teacher t = it.next();
                              
                   %>
                    
                    <div class="col-sm-6 col-md-3">
                        <div class="card mb-3 card1">
                            <div class="row g-0 align-items-center justify-content-between">
                                <div class="col-4 col-md-4">
                                    <img src="./userimg/<%= t.getTimg() %>" class="img-fluid rounded-start teacher-img" alt="...">
                                </div>
                                <div class="col-8 col-md-8">
                                    <div class="card-body">
                                        <h5 class="card-title"><%= t.getTname() %></h5>
                                        <p class="card-text mb-0"><%= t.getTsem() %>(<%= t.getTsubject() %>) <%= t.getTsection() %></p>
                                        <div class="card-text mb-0 d-flex">
        
                                            <p class="mb-0">
                                                <span class="teacher-rv" value="">
                                                                <%
                                                    qtr =  "select sum(t_rval) from tech_rating where tid="+t.getTid()+" and sid="+st.getSid();
                           Statement st2 = con.createStatement();
                             rs = st2.executeQuery(qtr);
                            float star=0;
                            if(rs.next())
                            {
                            star = rs.getFloat(1);
           
                                      }
                         
                          String qtr1 = "select count(sid) from tech_rating where tid=? and sid=?";
                            ps = con.prepareStatement(qtr1);
                         
                           ps.setInt(1,t.getTid());
                           ps.setInt(2,st.getSid());
                          ResultSet rs1 = ps.executeQuery();
                            float user=0;
                            if(rs1.next())
                            {
                     
                             user = rs1.getInt(1);
                           
                              }
                            out.print(RatingCount.rcount(star,user));
                                           %>
                                                </span>
                                                <span>
                                                    <i
                                                        class="bi bi-star-fill star-bg"></i><i class="bi bi-star-fill star-bg"></i><i
                                                        class="bi bi-star-fill star-bg"></i><i class="bi bi-star-fill star-bg"></i><i class="bi bi-star-fill star-bg"></i>
                                                </span> 
                                            </p>
                                        </div>
                                                    <i class="bi bi-person-fill-check"></i>
                                              <% 
                                               out.println(user);
                                              %>
                                        <span class="bi bi-star rat-star1" data-bs-toggle="modal" data-bs-target="#exampleModal1" value="<%=t.getTid()%>">Rate
                                       
                                        
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
        
                 <% } %>
        
        
                </div>
                        <div class="row">
                    <div class="col-8 col-sm-5 col-md-3 col-lg-2 mb-4">
                        <h4>Comments</h4>
                    </div>
                </div>
                 <div class="row student_comments">
                     
                     
                     
                 </div>
                </div>
        </div>
         <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Rating</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
              
                    <span style="font-size:2rem" class="contain-star">
                        <i class="bi bi-star-fill user-rate" id="pq"></i><i class="bi bi-star-fill user-rate"></i><i
                            class="bi bi-star-fill user-rate"></i><i class="bi bi-star-fill user-rate"></i><i
                            class="bi bi-star-fill user-rate"></i>
                        <div><span class="counting-star">0</span>/5</div>
                    </span>
                       <div class="alert alert-success" role="alert" style="display:none">
                    </div>
                </div>
                <div class="modal-footer">
                    
                    <button type="button" class="btn btn-primary college-post">Post</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="exampleModal1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Rating</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                   
                    <span style="font-size:2rem" class="contain-star1">
                        <i class="bi bi-star-fill user-rate1" id="pq"></i><i class="bi bi-star-fill user-rate1"></i><i
                            class="bi bi-star-fill user-rate1"></i><i class="bi bi-star-fill user-rate1"></i><i
                            class="bi bi-star-fill user-rate1"></i>
                        <div><span class="counting-star1">0</span>/5</div>
                    </span>
                         <div class="alert alert-success" role="alert" style="display:none">
                    </div>
                </div>
                <div class="modal-footer">
    
                    <button type="button" class="btn btn-primary teacher-post">Post</button>
                </div>
            </div>
        </div>
    </div>
         <% }
else if(vs!=null)
{
%>

<div class="container">
    <div class="row p-5 mt-5" style="background-color:#4c5185; border-radius:1rem;broder-bottom-left-radius:0px;">
    <div class="p-3"></div> 
    </div>
    <div class="row">
        <div class="col-12 col-md-4" style="position:relative;left:-0.7rem;">
           <div class="card d-flex align-items-center border-0">
               <img src="./userimg/<%=vs.getVimg()%>" class="card-img-top" alt="...." style=" height:8rem;width:8rem;border-radius:50%;position: relative;bottom:5rem;">
               <div class="card-body" style="position: relative;bottom: 5rem;">
            <h5 class="card-title"><%= vs.getVname()%></h5>
            <p class="card-text"><%=vs.getVcity()%></p>

            <p class="card-text"><%= vs.getVemail()%></p>
              <p class="card-text"><%= vs.getMobile_no()%></p>
              <a class="dropdown-item visitor-logout" style="cursor:pointer;color:#3640a0;font-weight:700;background-color: #f3f4fe;width: 5.5rem;border-radius: 1rem;box-shadow: 0px 3px 10px -5px black;font-weight: 500;opacity: 95%">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Logout
                                </a>
            </div>
            
           </div>
        </div>
         <div class="col-12 col-md-8">
             <div class="row mt-2 position-relative">
                 <div class="col-8 col-sm-6 col-md-4 mb-4">
                     <h4>Reviews</h4>
                 </div>
                 <div class="col-4 col-md-4 position-absolute end-0">
                  <button type="button" class="btn btn-sm view-all-btn" style="background:linear-gradient(0deg,rgb(84,90,158)0%,rgb(81,141,180)100%);
                  color:white !important;" href="./view_all_feedback.jsp">view All</button>
                    
                </div>
             </div>
   
             <div class="row">
                           <%
               int vid=vs.getVid();
                 commentdao cd1 = new commentdao(ConnectionProvider.getConnection());
    Vector<comment> vc = cd1.getvisitorcomment(vid);
    Iterator<comment> it = vc.iterator();
    int i=0;
    if(it.hasNext())
    {
    
                           
while (it.hasNext()&&i<4) {
     
comment cm=it.next();
 

i++;
             %>
                 <div class="col-11 col-md-5 comment-contain  m-2">
                     <div class="comment-header">
                         <img src="./userimg/<%=vs.getVimg() %>" alt="" style="border-radius:50%;"/>
                         <p style="font-size: 0.8rem;opacity: 60%" ><%=vs.getVname() %></p>
                         
                        </div>
                        <div class="comment-text mt-1">
                            <p class="mb-1">
                                <%=cm.getComment() %>
                            </p>
                            </div>
                            <div class="reply-contain mb-0 p-0 m-0">
                                <p style="font-size:0.8rem" class="p-0 m-0">Likes  <% 
                                    commentdao cd2= new commentdao(ConnectionProvider.getConnection());
                                    out.println(cd2.countlike(cm.getCom_id()));
                                    %></p>
                                <p style="font-size:0.8rem;margin-left:5px" class="p-0 m-0">DisLikes  <%
                                     
                                    out.println(cd2.countdislike(cm.getCom_id()));
                                    %></p>
                            </div>
                            <div class="d-flex" style="position: relative">
                            <p style="font-size:0.8rem;color:gray;" class="mt-1"><%           
                                  collegedao cd = new collegedao(ConnectionProvider.getConnection());
                                  college col = cd.findcollege(cm.getCid());
                                 out.println(col.getCname());
                                 %></p>
                        
                            <i class="bi bi-trash3-fill  text-danger delete-com" style="position: absolute;right:0px;"></i>
                            
                       <input type="hidden" value="<%=cm.getCom_id()%>">
                            </div>
                        </div>
      
             <%}}else
{
   out.println("<h5 class='text-center mt-2 my-h5' style='color:gray'>No any comment is found </h5>");
}%>
               
                 </div>
             </div>
         </div>
    </div>

<%}

else{ response.sendRedirect("./studentlogin.jsp"); } %>

             
    <script src="./jquery/jquery.js"></script>

<script>
    //get comments
    $(document).ready(function()
    {
    
        $.ajax({
            url:"./getstudentcomment.jsp",
            success:function(data)
            {
                $(".student_comments").html(data);
                
            }
        });
    });
    //student logout
    $(".student-logout").on("click",function()
    {
        if(confirm("Are you sure to logout"))
        {
            window.location.href="./studentlogout.jsp";
        }
    })
        $(".visitor-logout").on("click",function()
    {
        if(confirm("Are you sure to logout"))
        {
            window.location.href="./visitorlogout.jsp";
        }
    })
 $(".view-all-btn").on("click",function()
 {
   let text = $(".my-h5").text();
   if(text == "")
   {
          window.location.href="./view_all_feedback.jsp"; 
   }else
   {
 

   }
       

 });
   
 //send rating to database
 let tid;
 $(".rat-star1").on("click",function()
 {
    tid = $(this).attr("value"); 
 });
 $(".teacher-post").on("click",function()
 {
         //console.log("CLICK USERPOST2"); 
   let stat_fill = $(".counting-star1").text();     
   let cid = $(".cid").attr("value");
   let selected_card = "Teacher";
   let sid = $(".sid").attr("value");
   let card_id= tid;
     $.ajax({
        url:"addcollegerating",
        data:{"star_fill": stat_fill ,"select_card":selected_card,"cid":cid,"sid":sid,"id":card_id},
        success:function(data)
        {
            window.location.href="./profile.jsp";
        }
    });
 });

 $(".college-post").on("click",function()
 {
    let star_fill = $(".counting-star").text();
    let cid = $(".cid").attr("value");
    let selected_card="college";
    let sid = $(".sid").attr("value");
    let card_id=0;
    $.ajax({
        url:"addcollegerating",
        data:{"star_fill":star_fill,"select_card":selected_card,"cid":cid,"sid":sid,"id":card_id},
        success:function(data)
        {
            window.location.href="./profile.jsp";
        }
    });
 });

//user rating
 $(".user-rate1").on("click", function () {
    
            let co_star = $(".counting-star1").text();
    
            let v = $(this).attr('style');
            if (v != undefined) {
    
                let pre = $($(this).next()).attr("style");
    
                if (pre == undefined) {
    
                    $(this).removeAttr("style");
                    co_star--;
                    console.log("forward " + co_star);
                    $(".counting-star1").text(co_star);
    
                }
            } else {
    
                let pre = $($(this).prev()).attr("style");
                console.log("forward style :" + $($(this).prev()).attr("style"));
                if (pre != undefined || $(this).prev().length == 0) {
                    $(this).css("color", "gold");
                    co_star++;
                    console.log("forward " + co_star);
                    $(".counting-star1").text(co_star);
    
                }
            }
    
        });
   $(".user-rate").on("click", function () {
    
            let co_star = $(".counting-star").text();
    
            let v = $(this).attr('style');
            if (v != undefined) {
    
                let pre = $($(this).next()).attr("style");
    
                if (pre == undefined) {
    
                    $(this).removeAttr("style");
                    co_star--;
                    $(".counting-star").text(co_star);
                }
            } else {
    
                let pre = $($(this).prev()).attr("style");
    
                if (pre != undefined || $(this).prev().length == 0) {
                    $(this).css("color", "gold");
                    co_star++;
                    $(".counting-star").text(co_star);
                }
            }
    
         });

//set star based on database
   let  rat = $(".rat-value").text();
  
    let nexele = $($(".rat-value").next()).children();
     rat=rat.trim();
    let fill = parseInt(rat);

   let x;
   
  
    for (x = fill; x < 5; x++)
    {
  
        $(nexele[x]).removeClass("star-bg");
    }
  
    if ( fill < rat)
    {
  
        $(nexele[fill]).removeClass("bi-star-fill");
        $(nexele[fill]).addClass("bi-star-half");
        $(nexele[fill]).addClass("star-bg");
       
    }
    
   //teacher rating set based on database
   
          let  val = $(".teacher-rv");
   let c1,nextele,nextchild;
        for (c1 = 0; c1 < val.length; c1++)
        {
           let inn1 = parseInt(val[c1].innerText);
            nextele = $(val[c1]).next();
            nextchild = nextele.children();

            for (x = inn1; x < 5; x++)
            {

            
                $(nextchild[x]).removeClass("star-bg");
            }
 
            if (inn1 < val[c1].innerText)
            {
                
               
                $(nextchild[inn1]).removeClass("bi-star-fill");
                $(nextchild[inn1]).addClass("bi-star-half");
                $(nextchild[inn1]).addClass("star-bg");
            }
        }
    
    //comment delete by visitor
        $(".delete-com").on("click",function()
             {
                let con = confirm("Are you sure to delete comment");
                if(con==true)
                {
                    let sib = $(this).siblings();
                     console.log(sib); 
                    let com_id = $(sib[1]).attr("value");
                    console.log(com_id);
                    
//                    let cid = $(sib[1]).attr("value");
             
                    $.ajax({
                        url:"deletecomment",
                        data:{"com_id":com_id},
                        success:function(data)
                        {
                                           
                          window.location.href="./profile.jsp";
                        }
                    });
                }
             });


</script>
<br><br>
<%@include  file="./footer.html" %>
</body>
</html>

