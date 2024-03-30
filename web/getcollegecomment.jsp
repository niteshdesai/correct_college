<%@page import="entity.com_reply"%>
<%@page import="entity.collegeadmin"%>
<%@page import="entity.admin"%>
<%@page import="entity.visitor"%>
<%@page import="dao.visitiordao"%>
<%@page import="entity.student,java.sql.*"%>
<%@page import="dao.studentdao"%>
<%@page import="java.util.Iterator"%>
<%@page import="entity.comment"%>
<%@page import="java.util.Vector"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.commentdao"%>
<style>
  
    </style>
<div class="row">
<%
    String pre_user="default";
                   admin ad = (admin)session.getAttribute("adminlogin");

            collegeadmin cd = (collegeadmin)session.getAttribute("collegeadmin");
            

            visitor vs = (visitor)session.getAttribute("visitorlogin");

            student stu = (student)session.getAttribute("loginstudent");
     if(stu!=null)
     {
     pre_user="student";
}
if(vs!=null)
{
 pre_user="visitor";
}
if(cd!=null)
{
pre_user="college_admin";
}
if(ad!=null)
{
pre_user="admin";
}

    int cid = Integer.parseInt(request.getParameter("cid"));
    commentdao cd1 = new commentdao(ConnectionProvider.getConnection());
    Vector<comment> vc = cd1.getcomment(cid);
    Iterator<comment> it = vc.iterator();
    if(it.hasNext())
    {
    while (it.hasNext()) {

        comment cm = it.next();
        Vector<com_reply> cr1 = cd1.getcom_reply(cm.getCom_id());
        Iterator<com_reply> it1 = cr1.iterator();
        com_reply cr2 = new com_reply();
        com_reply cr = new com_reply();
        while(it1.hasNext())
        {
          cr2= it1.next();
         System.out.println(cr2.getSid()+" "+cr2.getVid()+" "+cr2.getCid()+" "+cr2.getAid());
          if(pre_user.equals("student"))
          {
           if(cr2.getSid()==stu.getSid())
             cr=cr2;
          }
            if(pre_user.equals("visitor"))
          {
           // System.out.println("vid = "+cr2.getVid());
           if(cr2.getVid()==vs.getVid())
            {cr=cr2;}
             
          }
             if(pre_user.equals("college_admin"))
          {
           if(cr2.getCid()== cd.getCa_id())
             cr=cr2;
          }
             if(pre_user.equals("admin"))
          {
           if(cr2.getAid()== ad.getAid())
             cr=cr2;
          }
          
      
        }
        String cname=null;
        String cimg=null;
        if (cm.getSid() != 0) {
           
            studentdao sd  = new studentdao(ConnectionProvider.getConnection());
            student st = sd.findstudent(cm.getSid());
            cname=st.getSname();
            cimg=st.getSimg();
        } else {
          
            visitiordao vd = new visitiordao(ConnectionProvider.getConnection());
            visitor vc1 = vd.findvisitor(cm.getVid());
            cname=vc1.getVname();
            cimg = vc1.getVimg();
        }

                commentdao com_da = new commentdao(ConnectionProvider.getConnection());
%>

<input type="hidden" value="<% if(stu!=null){ out.println(stu.getSid()); }%>" class="sid"/><!-- comment -->
<input type="hidden" value="<% if(vs!= null){ out.println(vs.getVid()); }%>" class="vid"/><!-- comment -->
<input type="hidden" value="<% if(cd!=null){ out.println(cd.getCa_id());} %>" class="caid"/>
<input  type="hidden" value="<% if(ad!=null){ out.println(ad.getAid()); } %>" class="aid"/>
<div class="col-5 comment a-2">
    <div class="comment-header">
        <img src="./userimg/<%= cimg %>" alt="" style="border-radius:50%;height:2rem;width:2rem;"/>
        <p><%= cname %></p>

    </div>
    <div class="comment-text at-1">
            <p class="mb-1"><%= cm.getComment() %></p>
    </div>   
    <div class="reply-contain mb-2">
        <div>
            <span class="like-dilike-icon-contain " style=" cursor: pointer;" >
                <input type="hidden" value="<%= cm.getCom_id() %>" name="com_id" class="com_id"/>
                <% 
                  boolean check = false;
               
                  if(stu!=null)
                  {
                    if(cr.getSid() == stu.getSid() && cr.getCom_like()==1)
                    {
                    check=true;
                  
                  %>
                  <i class="bi bi-hand-thumbs-up-fill like-btn" value="1" style="color:blue"></i>
                 <% }}
else if(vs!=null)
{

if( cr.getCom_like()==1 && cr.getVid()==vs.getVid())
                  {
check=true;

                  %>
                  <i class="bi bi-hand-thumbs-up-fill like-btn" value="1" style="color:blue"></i>
                 <% }}
else if(cd!=null)
{
if(cr.getCom_like()==1 && cr.getCid() == cd.getCa_id())
                  {
check=true;
                  %>
                  <i class="bi bi-hand-thumbs-up-fill like-btn" value="1" style="color:blue"></i>
                 <% }}
else if(ad!=null)
{
 if(cr.getCom_like()==1 && cr.getAid() == ad.getAid())
                  {
check=true;
                  %>
                  <i class="bi bi-hand-thumbs-up-fill like-btn" value="1" style="color:blue"></i>
                 <% }}
                else
                {
check =true;
                %>
                 <i class="bi bi-hand-thumbs-up-fill like-btn" value="0" style="color:gray"></i>
              <%  }

                 if(check==false)
{
                %>
               <i class="bi bi-hand-thumbs-up-fill like-btn" value="0" style="color:gray"></i>
           <% }%>
         
            </span>
                   <span class="ms-2 like-count-value">
                    
                       <% 
           
                       out.println(com_da.countlike(cm.getCom_id()));
                    %>
                </span>
        </div>
        <div>
            <span class="like-dilike-icon-contain " style=" cursor: pointer;">
        <input type="hidden" value="<%= cm.getCom_id() %>" name="com_id" class="com_id"/>
        
           
              
               <% 
                              check = false;
                  if(stu!=null)
                  {
                    if(cr.getSid() == stu.getSid() && cr.getCom_dlike()==1)
                    {
                    check=true;
                
                  %>
                  <i class="bi bi-hand-thumbs-down-fill unlike-btn" value="1" style="color:blue"></i>
                 <% }}
else if(vs!=null)
{
if( cr.getCom_dlike()==1 && cr.getVid()==vs.getVid())
                  {
check=true;
                  %>
                  <i class="bi bi-hand-thumbs-down-fill unlike-btn" value="1" style="color:blue"></i>
                 <% }}
else if(cd!=null)
{
if(cr.getCom_dlike()==1 && cr.getCid() == cd.getCa_id())
                  {
check=true;
                  %>
                  <i class="bi bi-hand-thumbs-down-fill unlike-btn" value="1" style="color:blue"></i>
                 <% }}
else if(ad!=null)
{
 if(cr.getCom_dlike()==1 && cr.getAid() == ad.getAid())
                  {
check=true;
                  %>
                  <i class="bi bi-hand-thumbs-down-fill unlike-btn" value="1" style="color:blue"></i>
                 <% }}
                else
                {
check =true;
                %>
                 <i class="bi bi-hand-thumbs-down-fill unlike-btn" value="0" style="color:gray"></i>
              <%  }

                 if(check==false)
{
                %>
               <i class="bi bi-hand-thumbs-down-fill unlike-btn" value="0" style="color:gray"></i>
           <% }%>
               
   
            </span>
                <span class="ms-2 dislike-count-value">
                    <% 
            
                       out.println(com_da.countdislike(cm.getCom_id()));
                    %>
                </span><!-- comment -->
              
        </div>
 
    </div>
                <% if(ad!=null && (cd==null && vs==null && stu==null)) 
                {%>
                
                <div class="text-end pb-1"><i class="bi bi-trash3-fill  text-danger delete-com"></i>
                 <input type="hidden" value="<%= cm.getCom_id() %>" class="com_id"/>
                                  <input type="hidden" value="<%= cm.getCid() %>" class="cid"/>
                </div>
                <% } %>
</div>

<%  } } else{

   out.println("<h5 class='text-center' style='color:gray'>No any Feedback is found</h5>");
}%>
 <script src="./jquery/jquery.js"></script>
<script>
      $(".delete-com").on("click",function()
             {
                let con = confirm("Are you sure to delete comment");
                if(con==true)
                {
                    let sib = $(this).siblings();
                 
                    let com_id = $(sib[0]).attr("value");
                    let cid = $(sib[1]).attr("value");
             
                    $.ajax({
                        url:"deletecomment",
                        data:{"com_id":com_id},
                        success:function(data)
                        {
                                           
                          window.location.href="./newadmin.jsp";
                        }
                    });
                }
             });
    
    
    
     sid1= $(".sid").attr("value");
     vid1 = $(".vid").attr("value");
     caid = $(".caid").attr("value");
    aid = $(".aid").attr("value");
        
     console.log("getcomments page");
     console.log("sid = "+sid1);
  
     console.log("vid1 = "+vid1);
     console.log("caid ="+caid);
     console.log("aid = "+aid);
     
   id5,category;
     if(sid1!="")
     {
         id5=sid1;
         category="student";
     }
     
     if(vid1!="")
     {
         id5=vid1;
          category="visitor";
     }
     
     if(caid!="")
     {
        id5=caid;
        category="collegeadmin";
     }
     
     if(aid!="")
     {
         id5=aid;
          category="admin";
     }
   
    $(".like-btn").on("click",function()
    {
         if(sid1=="" && caid=="" && aid=="" && vid1=="")
     {
         window.location.href="./visitorlogin.jsp";
     }
     else
     {
         let sib = $(this).siblings();
         let com_id = $(sib[0]).attr("value");
              let value = $(this).attr("value");
         let parent = $(this).parent();
  
         let liker_count = $(parent).siblings();
         console.log("find like and dislike value");
                let grand_parent= $(parent).parent();
        
         let grand_sib = $(grand_parent).siblings();
         let gs_sib1 = $(grand_sib).children();
         let gs_sib_icon = $(gs_sib1).children();
         let dlike_cout = gs_sib1[1];
         let gs_icon_value = $(gs_sib_icon[1]).attr("value");
//         console.log(gs_sib_icon[1]);
//         console.log(dlike_cout);
//         console.log(parent);
//         console.log(liker_count);
        if(gs_icon_value==1)
            {
              $(gs_sib_icon[1]).attr("style","color:gray");
              $(gs_sib_icon[1]).attr("value","0");
            }
        if(value==0)
        { 
         
            $(this).attr("style","color:blue");
            $(this).attr("value","1");
            console.log("check before send ajax request to add_com_reply");
           console.log("id ="+id5);
           console.log("category ="+category);
            $.ajax({
            url:"add_com_reply",
            data:{"com_id":com_id,"id":id5,"category":category,"like":1,"dislike":0},
            success:function(data)
            {

                let d = data.split("^");
                $(liker_count).text(d[0]);
                $(dlike_cout).text(d[1]);
            }
         });
        }
        else
        { 
            $(this).attr("style","color:gray");
            $(this).attr("value","0");
               console.log("check before send ajax request to add_com_reply");
            console.log("id ="+id5);
           console.log("category ="+category);
            $.ajax({
            url:"add_com_reply",
            data:{"com_id":com_id,"id":id5,"category":category,"like":0,"dislike":0},
            success:function(data)
            {
                      let d = data.split("^");
                $(liker_count).text(d[0]);
                 $(dlike_cout).text(d[1]);
            }
         });
            
        }
         

   
        
     }
    });
    
    $(".unlike-btn").on("click",function()
    {
          if(sid1=="" && caid=="" && aid=="" && vid1=="")
          
     {
         window.location.href="./visitorlogin.jsp";
     }
     else
     {
         
          let sib = $(this).siblings();
         let com_id = $(sib[0]).attr("value");
              let value = $(this).attr("value");
              
                let parent = $(this).parent();
         
         let di_like_counter = $(parent).siblings();
             console.log("find like and dislike value");
                let grand_parent= $(parent).parent();
//         console.log(grand_parent);
         let grand_sib = $(grand_parent).siblings();
         let gs_sib1 = $(grand_sib).children();
         let gs_sib_icon = $(gs_sib1).children();
         let like_cout = $(gs_sib1[0]).siblings();
         let gs_icon_value = $(gs_sib_icon[1]).attr("value");
         console.log(gs_sib_icon[1]);
         console.log("liker coutn");
         console.log(like_cout[0]);
         
           if(gs_icon_value==1)
            {
              $(gs_sib_icon[1]).attr("style","color:gray");
              $(gs_sib_icon[1]).attr("value","0");
            }
          
        if(value==0)
        { 
            $(this).attr("style","color:blue");
            $(this).attr("value","1");
            console.log("unlike btn click : "+com_id+" "+id5+" "+category+" "+0+" "+1);
            $.ajax({
            url:"add_com_reply",
            data:{"com_id":com_id,"id":id5,"category":category,"like":0,"dislike":1},
            success:function(data)
            {
                
                      let d = data.split("^");
                $(di_like_counter).text(d[1]);
                $(like_cout[0]).text(d[0]);
            }
         });
        }
        else
        { 
            $(this).attr("style","color:gray");
            $(this).attr("value","0");
                console.log("unlike btn click : "+com_id+" "+id5+" "+category+" "+0+" "+0);
            $.ajax({
            url:"add_com_reply",
            data:{"com_id":com_id,"id":id5,"category":category,"like":0,"dislike":0},
            success:function(data)
            {
                       let d = data.split("^");
                $(di_like_counter).text(d[1]);
                  $(like_cout[0]).text(d[0]);
            }
         });
            
        }
         

   
     }   
    });
    
    
</script>

</div>